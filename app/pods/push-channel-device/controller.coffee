`import Ember from 'ember'`

PushChannelDeviceController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default PushChannelDeviceController`
