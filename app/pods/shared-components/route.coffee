`import Ember from 'ember'`

SharedComponentsRoute = Ember.Route.extend
  model: -> @modelFor('api').get 'shared_components'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default SharedComponentsRoute`
