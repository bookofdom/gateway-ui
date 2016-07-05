`import Ember from 'ember'`

PushDeviceIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'push-device.edit'

`export default PushDeviceIndexRoute`
