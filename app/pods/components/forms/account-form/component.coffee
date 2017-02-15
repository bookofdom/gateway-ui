`import Ember from 'ember'`
`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import Registration from 'gateway-ui/pods/registration/model'`
`import { brandName } from 'gateway-ui/helpers/brand-name'`
`import t from 'gateway-ui/helpers/i18n'`

AccountFormComponent = BaseFormComponent.extend
  subscription: Ember.inject.service()
  stripeCheckout: Ember.inject.service()

  modelType: 'account'
  plans: null

  horizontal: false
  savedAction: null
  'show-delete': false

  isNonZeroPlanAmount: Ember.computed.and 'subscription.enabled', 'model.plan.isBillable'

  # if plan was changed AND payment is required, we need to hide the change
  # payment button and make payment a required part of checkout
  changedPlanPaymentRequired: Ember.computed.and 'model.hasChangedBelongsTo', 'isNonZeroPlanAmount'

  'option-groups': Ember.computed ->
    plan: Registration.plans

  fields: [
    name: 'name'
    label: false
    required: true
  ]

  save: ->
    model = @get 'model'
    model.save().finally =>
      if !model.get 'errors.messages.length'
        # TODO begin hack
        # force update of computed properties used to
        # determine if payment is required or payment
        # information may be updated
        plan = model.get 'plan'
        model.set 'plan', null
        model.set 'plan', plan
        # end hack
        @notifySaveSuccess()
        @sendAction 'savedAction', model

  submit: ->
    model = @get 'model'
    stripeCheckoutService = @get 'stripeCheckout'
    changedPlanPaymentRequired = @get 'changedPlanPaymentRequired'
    if !changedPlanPaymentRequired
      @save()
    else
      checkout = stripeCheckoutService.getToken
        name: brandName 'primary'
        description: model.get 'plan.name'
        zipCode: true
        amount: model.get 'plan.price'
        panelLabel: null
      checkout.then (token) =>
        model.set 'stripe_token', token.id if token
        @save()
    false

  actions:
    changePayment: ->
      model = @get 'model'
      stripeCheckoutService = @get 'stripeCheckout'
      checkout = stripeCheckoutService.getToken
        name: brandName 'primary'
        description: model.get 'plan.name'
        zipCode: true
        panelLabel: t 'actions.change-payment'
      checkout.then (token) =>
        model.set 'stripe_token', token.id if token
        @save()

`export default AccountFormComponent`
