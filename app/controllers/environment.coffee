`import Ember from 'ember'`

EnvironmentController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default EnvironmentController`
