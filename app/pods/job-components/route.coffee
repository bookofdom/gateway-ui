`import Ember from 'ember'`

JobComponentsRoute = Ember.Route.extend
  model: -> @modelFor('job').get 'components'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default JobComponentsRoute`
