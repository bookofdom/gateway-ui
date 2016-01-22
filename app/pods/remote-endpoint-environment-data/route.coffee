`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDataRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('remote-endpoint').get 'environment_data'
  actions:
    saved: ->
      # no op (this action is for use by the new datum route)

`export default RemoteEndpointEnvironmentDataRoute`
