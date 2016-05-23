`import Ember from 'ember'`

RemoteEndpointPushPlatformIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'remote-endpoint-environment-datum-push-platform.edit'

`export default RemoteEndpointPushPlatformIndexRoute`
