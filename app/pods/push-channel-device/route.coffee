`import Ember from 'ember'`

PushChannelDeviceRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('push-channel-devices').findBy 'id', params.push_channel_device_id
  actions:
    deleted: ->
      @transitionTo 'push-channel-devices'

`export default PushChannelDeviceRoute`
