`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`
`import PlansRouteMixin from 'gateway/mixins/plans-route'`
`import t from 'gateway/helpers/i18n'`

RegistrationRoute = Ember.Route.extend UnauthenticatedRouteMixin, PlansRouteMixin,
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.sign-up'
      @transitionTo 'login'
      @get('notify').info successMessage

`export default RegistrationRoute`
