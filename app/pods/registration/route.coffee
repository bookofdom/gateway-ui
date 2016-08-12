`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`
`import SubscriptionPlansRouteMixin from 'gateway/mixins/subscription-plans-route'`
`import t from 'gateway/helpers/i18n'`

RegistrationRoute = Ember.Route.extend UnauthenticatedRouteMixin, SubscriptionPlansRouteMixin,
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.sign-up'
      @transitionTo 'login'
      @get('notify').info successMessage

`export default RegistrationRoute`
