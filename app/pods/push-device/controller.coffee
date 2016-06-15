`import Ember from 'ember'`

PushDeviceController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default PushDeviceController`
