`import Ember from 'ember'`

PushChannelDevicesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel').get 'push_devices'

`export default PushChannelDevicesRoute`
