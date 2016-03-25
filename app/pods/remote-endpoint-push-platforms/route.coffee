`import Ember from 'ember'`

RemoteEndpointPushPlatformsRoute = Ember.Route.extend
  model: -> @modelFor('remote-endpoint').get 'push_platforms'

`export default RemoteEndpointPushPlatformsRoute`
