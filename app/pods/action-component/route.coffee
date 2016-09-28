`import Ember from 'ember'`

ActionComponentRoute = Ember.Route.extend
  model: (params) ->
    @modelFor(@get 'parentRouteName').findBy 'id', params.action_component_id
  actions:
    deleted: ->
      @transitionTo @get('parentRoute.parentRoute.routeName')

`export default ActionComponentRoute`
