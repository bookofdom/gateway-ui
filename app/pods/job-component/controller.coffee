`import Ember from 'ember'`

JobComponentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.nameKey', -> @get 'model.nameKey'

`export default JobComponentController`
