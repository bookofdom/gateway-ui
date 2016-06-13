`import Ember from 'ember'`

PushChannelPushDevicePushMessageRoute = Ember.Route.extend
  model: (params) -> @modelFor('push-channel-push-device-push-messages').findBy 'id', params.push_message_id
  actions:
    deleted: ->
      @transitionTo 'push-channel-push-device-push-messages'

`export default PushChannelPushDevicePushMessageRoute`
