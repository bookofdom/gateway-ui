`import Ember from 'ember'`

PushChannelMessagesRoute = Ember.Route.extend
  model: -> @store.findAll 'push-channel-message'

`export default PushChannelMessagesRoute`
