`import Ember from 'ember'`

ScratchPadController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ScratchPadController`
