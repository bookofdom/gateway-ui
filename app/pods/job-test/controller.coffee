`import Ember from 'ember'`

JobTestController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default JobTestController`
