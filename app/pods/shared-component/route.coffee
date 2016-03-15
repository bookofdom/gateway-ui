`import Ember from 'ember'`

SharedComponentRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('shared-components').findBy 'id', params.shared_component_id
  actions:
    deleted: ->
      @transitionTo 'shared-components'

`export default SharedComponentRoute`
