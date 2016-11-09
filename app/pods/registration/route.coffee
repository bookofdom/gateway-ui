`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`
`import t from 'gateway/helpers/i18n'`

RegistrationRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.sign-up'
      @transitionTo 'registration.success'
      @get('notify').info successMessage

`export default RegistrationRoute`
