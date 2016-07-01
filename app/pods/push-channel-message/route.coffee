`import Ember from 'ember'`

PushChannelMessageRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('push-channel-messages').findBy 'id',
      params.push_channel_message_id

`export default PushChannelMessageRoute`
