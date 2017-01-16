`import Ember from 'ember'`
`import config from 'gateway-ui/config/environment'`

SubscriptionService = Ember.Service.extend Ember.Evented,
  stripeCheckout: Ember.inject.service()
  enablePlanSubscriptions: Ember.computed ->
    config.enablePlanSubscriptions?.toString() is 'true'
  devMode: config.dev_mode?.toString() is 'true'

  enabled: Ember.computed 'stripeCheckout.isEnabled', 'enablePlanSubscriptions', 'devMode', ->
    @get('stripeCheckout.isEnabled') and
      @get('enablePlanSubscriptions') and
      !@get('devMode')

`export default SubscriptionService`
