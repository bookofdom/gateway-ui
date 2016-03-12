`import Ember from 'ember'`

StoreCollectionRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('store-collections').findBy 'id', params.collection_id
  actions:
    deleted: ->
      @transitionTo 'store-collections'

`export default StoreCollectionRoute`
