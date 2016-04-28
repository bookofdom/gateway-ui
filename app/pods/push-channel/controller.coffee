`import Ember from 'ember'`

PushChannelController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default PushChannelController`
