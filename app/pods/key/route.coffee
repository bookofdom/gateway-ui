`import Ember from 'ember'`

KeyRoute = Ember.Route.extend
  model: (params) -> @modelFor('keys').findBy 'id', params.key_id
  actions:
    deleted: ->
      @transitionTo 'keys'

`export default KeyRoute`
