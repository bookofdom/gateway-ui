`import Ember from 'ember'`

PushDevicesRoute = Ember.Route.extend
  model: -> @store.findAll 'push-device'

`export default PushDevicesRoute`
