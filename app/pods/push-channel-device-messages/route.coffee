`import Ember from 'ember'`

PushChannelDeviceMessagesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel-device').get 'push_messages'

`export default PushChannelDeviceMessagesRoute`
