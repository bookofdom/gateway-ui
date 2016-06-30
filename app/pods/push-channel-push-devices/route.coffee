`import Ember from 'ember'`

PushChannelPushDevicesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel').get 'push_devices'

`export default PushChannelPushDevicesRoute`
