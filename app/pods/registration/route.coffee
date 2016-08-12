`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`
`import config from  'gateway/config/environment'`
`import t from 'gateway/helpers/i18n'`

RegistrationRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  notify: Ember.inject.service()
  stripeService: Ember.inject.service 'stripe'
  isSubscriptionEnabled: Ember.computed 'stripeService.enabled', ->
    @get('stripeService.enabled') and (config.enablePlanSubscriptions?.toString() is 'true')
  afterModel: ->
    if @get 'isSubscriptionEnabled'
      Ember.RSVP.hash
        subscription_plans: @store.findAll 'subscription-plan'
      .then (results) =>
        @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels if extraModels
    @_super arguments...
  actions:
    saved: ->
      successMessage = t 'successes.sign-up'
      @transitionTo 'login'
      @get('notify').info successMessage

`export default RegistrationRoute`
