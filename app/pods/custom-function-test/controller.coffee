`import Ember from 'ember'`

CustomFunctionTestController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default CustomFunctionTestController`
