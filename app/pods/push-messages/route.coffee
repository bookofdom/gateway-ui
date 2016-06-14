`import Ember from 'ember'`

PushMessagesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel-push-device').get 'push_messages'

`export default PushMessagesRoute`
