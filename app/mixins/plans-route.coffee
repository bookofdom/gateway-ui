`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

# Loads subscription plans into the controller associated with this route.
PlansRouteMixin = Ember.Mixin.create
  subscription: Ember.inject.service()
  beforeModel: ->
    previous = @_super arguments...
    if @get 'subscription.enabled'
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
