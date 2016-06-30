`import Ember from 'ember'`

PushChannelDeviceMessageRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('push-channel-device-messages').findBy 'id',
      params.push_channel_device_message_id
  actions:
    deleted: ->
      @transitionTo 'push-channel-device-messages'

`export default PushChannelDeviceMessageRoute`
