`import Ember from 'ember'`
`import config from 'gateway/config/environment'`

SubscriptionService = Ember.Service.extend Ember.Evented,
  stripe: Ember.inject.service()
  enablePlanSubscriptions: Ember.computed ->
    config.enablePlanSubscriptions?.toString() is 'true'
  devMode: config.dev_mode?.toString() is 'true'

  enabled: Ember.computed 'stripe.enabled', 'enablePlanSubscriptions', 'devMode', ->
    @get('stripe.enabled') and
      @get('enablePlanSubscriptions') and
      !@get('devMode')

`export default SubscriptionService`
