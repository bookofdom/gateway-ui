`import Ember from 'ember'`

RemoteEndpointPushPlatformRoute = Ember.Route.extend
  model: (params) -> @modelFor('remote-endpoint-environment-datum-push-platforms').findBy 'id', params.push_platform_id

`export default RemoteEndpointPushPlatformRoute`
