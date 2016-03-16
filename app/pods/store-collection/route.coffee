`import Ember from 'ember'`

StoreCollectionRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('store-collections').findBy 'id', params.collection_id
  setupController: (controller) ->
    controller.set 'store_collections', @modelFor('store-collections')
    @_super arguments...
  renderTemplate: ->
    @_super arguments...
    @render 'store-collection/sidebar',
      outlet: 'sidebar'
      into: 'store-collection'
  actions:
    deleted: ->
      @transitionTo 'store-collections'

`export default StoreCollectionRoute`
