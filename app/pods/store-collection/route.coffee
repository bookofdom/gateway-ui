`import Ember from 'ember'`

StoreCollectionRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('store-collections').findBy 'id', params.collection_id
  setupController: (controller) ->
    controller.set 'store_collections', @modelFor('store-collections')
    @_super arguments...
  actions:
    deleted: ->
      @transitionTo 'store-collections'

`export default StoreCollectionRoute`
