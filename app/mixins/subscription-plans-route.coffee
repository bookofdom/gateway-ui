`import Ember from 'ember'`
`import config from  'gateway/config/environment'`

# Loads subscription plans into the controller associated with this route.
SubscriptionPlansRouteMixin = Ember.Mixin.create
  stripeService: Ember.inject.service 'stripe'
  isSubscriptionEnabled: Ember.computed 'stripeService.enabled', ->
    @get('stripeService.enabled') and (config.enablePlanSubscriptions?.toString() is 'true')
  afterModel: ->
    if @get 'isSubscriptionEnabled'
      Ember.RSVP.hash
        plans: @store.findAll 'subscription-plan'
      .then (results) =>
        @setProperties results
    @_super arguments...
  setupController: (controller) ->
    plans = @get 'plans'
    controller.set 'subscription_plans', plans if plans
    @_super arguments...

`export default SubscriptionPlansRouteMixin`
