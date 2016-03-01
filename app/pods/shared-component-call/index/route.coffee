`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentCallIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'shared-component-call.edit'

`export default SharedComponentCallIndexRoute`
