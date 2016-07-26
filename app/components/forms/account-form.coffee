`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import Registration from 'gateway/pods/registration/model'`
`import config from 'gateway/config/environment'`

AccountFormComponent = BaseFormComponent.extend
  stripeService: Ember.inject.service 'stripe'
  modelType: 'account'

  isSubscriptionEnabled: Ember.computed 'stripeService.enabled', ->
    @get('stripeService.enabled') and
      (config.enablePlanSubscriptions?.toString() is 'true')
  isNonZeroPlanAmount: Ember.computed 'isSubscriptionEnabled', 'model.isBillable', ->
    @get('isSubscriptionEnabled') and @get('model.isBillable')

  savedAction: null
  'show-delete': false

  'option-groups': Ember.computed ->
    plan: Registration.plans

  fields: [
    name: 'plan'
    type: 'select'
    required: true
  ]

`export default AccountFormComponent`
