`import Ember from 'ember'`

PushChannelDeviceIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'push-channel-device.edit'

`export default PushChannelDeviceIndexRoute`
