`import Ember from 'ember'`

PushMessageRoute = Ember.Route.extend
  model: (params) -> @modelFor('push-messages').findBy 'id', params.push_message_id
  actions:
    deleted: ->
      @transitionTo 'push-messages'

`export default PushMessageRoute`
