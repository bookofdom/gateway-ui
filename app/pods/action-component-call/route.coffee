`import Ember from 'ember'`

ActionComponentCallRoute = Ember.Route.extend
  model: (params) ->
     @get('parentModel').findBy 'id', params.action_component_call_id

`export default ActionComponentCallRoute`
