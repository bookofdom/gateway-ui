`import Ember from 'ember'`

EnvironmentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default EnvironmentController`
