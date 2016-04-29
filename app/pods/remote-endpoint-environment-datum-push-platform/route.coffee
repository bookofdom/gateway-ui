`import Ember from 'ember'`

RemoteEndpointPushPlatformRoute = Ember.Route.extend
  model: (params) -> @modelFor('remote-endpoint-environment-datum-push-platforms').findBy 'id', params.push_platform_id
  actions:
    saved: ->
      @transitionTo 'remote-endpoint-environment-datum'
    deleted: ->
      @transitionTo 'remote-endpoint-environment-datum'
    canceled: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointPushPlatformRoute`
