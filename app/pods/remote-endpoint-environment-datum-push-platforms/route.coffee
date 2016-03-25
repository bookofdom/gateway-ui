`import Ember from 'ember'`

RemoteEndpointPushPlatformsRoute = Ember.Route.extend
  model: -> @modelFor('remote-endpoint-environment-datum').get 'push_platforms'

`export default RemoteEndpointPushPlatformsRoute`
