`import Ember from 'ember'`

RemoteEndpointPushPlatformsRoute = Ember.Route.extend
  model: -> @modelFor('remote-endpoint-environment-datum').get 'push_platforms'
  actions:
    saved: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointPushPlatformsRoute`
