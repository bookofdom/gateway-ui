`import Ember from 'ember'`

PushMessagesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel-device').get 'push_messages'

`export default PushMessagesRoute`
