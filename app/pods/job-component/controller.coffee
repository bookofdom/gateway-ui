`import Ember from 'ember'`

JobComponentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default JobComponentController`
