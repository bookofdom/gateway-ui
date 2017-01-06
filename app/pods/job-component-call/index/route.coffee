`import Ember from 'ember'`

JobComponentCallIndexRoute = Ember.Route.extend
  afterModel: ->
    @transitionTo "job-component-call.edit"

`export default JobComponentCallIndexRoute`
