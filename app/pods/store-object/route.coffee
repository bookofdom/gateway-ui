`import Ember from 'ember'`

StoreObjectRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('store-objects').findBy 'id', params.object_id
  actions:
    deleted: ->
      @transitionTo 'store-collections'

`export default StoreObjectRoute`
