`import Ember from 'ember'`

SharedComponentCallRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('shared-component-calls').findBy 'id', params.shared_component_call_id

`export default SharedComponentCallRoute`
