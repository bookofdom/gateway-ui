`import Ember from 'ember'`

PushChannelRoute = Ember.Route.extend
  model: (params) -> @modelFor('push-channels').findBy 'id', params.push_channel_id
  actions:
    deleted: ->
      @transitionTo 'push-channels'

`export default PushChannelRoute`
