`import Ember from 'ember'`

CustomFunctionController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default CustomFunctionController`
