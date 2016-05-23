`import Ember from 'ember'`

PushChannelPushDeviceIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'push-channel-push-device.edit'

`export default PushChannelPushDeviceIndexRoute`
