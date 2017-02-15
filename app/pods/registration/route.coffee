`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`

RegistrationRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  notify: Ember.inject.service()
  actions:
    saved: ->
      @transitionTo 'registration.success'
      @get('notify').info 'successes.sign-up'

`export default RegistrationRoute`
