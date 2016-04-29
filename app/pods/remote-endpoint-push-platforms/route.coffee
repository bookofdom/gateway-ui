`import Ember from 'ember'`

RemoteEndpointPushPlatformsRoute = Ember.Route.extend
  model: -> @modelFor('remote-endpoint').get 'push_platforms'
  actions:
    saved: ->
      @transitionTo 'remote-endpoint'

`export default RemoteEndpointPushPlatformsRoute`
