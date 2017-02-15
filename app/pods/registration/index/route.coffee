`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`
`import PlansRouteMixin from 'gateway-ui/mixins/plans-route'`

RegistrationIndexRoute = Ember.Route.extend UnauthenticatedRouteMixin, PlansRouteMixin,
  queryParams:
    plan:
      refreshModel: true

`export default RegistrationIndexRoute`
