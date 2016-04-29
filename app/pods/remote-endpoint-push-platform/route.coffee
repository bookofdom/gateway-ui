`import Ember from 'ember'`

RemoteEndpointPushPlatformRoute = Ember.Route.extend
  model: (params) -> @modelFor('remote-endpoint-push-platforms').findBy 'id', params.push_platform_id
  actions:
    saved: ->
      @transitionTo 'remote-endpoint'
    deleted: ->
      @transitionTo 'remote-endpoint'
    canceled: ->
      @transitionTo 'remote-endpoint'

`export default RemoteEndpointPushPlatformRoute`
