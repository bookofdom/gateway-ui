`import Ember from 'ember'`

RemoteEndpointPushPlatformIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'remote-endpoint-push-platform.edit'

`export default RemoteEndpointPushPlatformIndexRoute`
