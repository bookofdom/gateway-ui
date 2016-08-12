`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import Registration from 'gateway/pods/registration/model'`
`import config from 'gateway/config/environment'`

AccountFormComponent = BaseFormComponent.extend
  stripeService: Ember.inject.service 'stripe'
  modelType: 'account'
  plans: null

  isSubscriptionEnabled: Ember.computed 'stripeService.enabled', ->
    @get('stripeService.enabled') and
      (config.enablePlanSubscriptions?.toString() is 'true')

  horizontal: false
  savedAction: null
  'show-delete': false

  'option-groups': Ember.computed ->
    plan: Registration.plans

  fields: [
    name: 'name'
    label: false
    required: true
  ]

`export default AccountFormComponent`
