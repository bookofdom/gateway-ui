`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    type:
      refreshModel: false

  model: -> @modelFor('api').get 'remote_endpoints'

`export default RemoteEndpointsRoute`
