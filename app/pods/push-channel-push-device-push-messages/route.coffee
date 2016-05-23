`import Ember from 'ember'`

PushChannelPushDevicePushMessagesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel-push-device').get 'push_messages'

`export default PushChannelPushDevicePushMessagesRoute`
