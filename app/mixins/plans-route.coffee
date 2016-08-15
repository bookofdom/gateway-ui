`import Ember from 'ember'`
`import config from  'gateway/config/environment'`

# Loads subscription plans into the controller associated with this route.
PlansRouteMixin = Ember.Mixin.create
  stripeService: Ember.inject.service 'stripe'
  isSubscriptionEnabled: Ember.computed 'stripeService.enabled', ->
    @get('stripeService.enabled') and (config.enablePlanSubscriptions?.toString() is 'true')
  beforeModel: ->
    previous = @_super arguments...
    if @get 'isSubscriptionEnabled'
      Ember.RSVP.hash
        plans: @store.findAll 'plan'
      .then (results) =>
        @setProperties results
    else
      previous
  setupController: (controller) ->
    plans = @get 'plans'
    controller.set 'plans', plans if plans
    @_super arguments...

`export default PlansRouteMixin`
