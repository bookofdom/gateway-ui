`import Ember from 'ember'`

PushChannelPushDeviceRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('push-channel-push-devices').findBy 'id',
      params.push_channel_push_device_id
  actions:
    deleted: ->
      @transitionTo 'push-channel-push-devices'

`export default PushChannelPushDeviceRoute`
