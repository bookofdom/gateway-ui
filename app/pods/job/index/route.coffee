`import Ember from 'ember'`

JobIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'job.edit'

`export default JobIndexRoute`
