`import Ember from 'ember'`

JobTestsRoute = Ember.Route.extend
  model: -> @modelFor('job').get 'tests'
  actions:
    saved: ->
      # no op (this event is for use by the new type test route)

`export default JobTestsRoute`
