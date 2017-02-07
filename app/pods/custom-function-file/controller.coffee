`import Ember from 'ember'`

CustomFunctionFileController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default CustomFunctionFileController`
