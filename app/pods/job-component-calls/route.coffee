`import Ember from 'ember'`

JobComponentCallsRoute = Ember.Route.extend
  model: -> @modelFor('job-component').get 'calls'

`export default JobComponentCallsRoute`
