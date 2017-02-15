`import Ember from 'ember'`

JobController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default JobController`
