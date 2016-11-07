`import Ember from 'ember'`

JobTestIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'job-test.edit'

`export default JobTestIndexRoute`
