`import Ember from 'ember'`

PushDevicesRoute = Ember.Route.extend
  model: -> @modelFor('push-channel').get 'push_devices'

`export default PushDevicesRoute`
