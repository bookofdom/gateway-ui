`import Ember from 'ember'`

PushChannelPushDeviceController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default PushChannelPushDeviceController`
