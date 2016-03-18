`import Ember from 'ember'`

StoreCollectionsIndexRoute = Ember.Route.extend
  afterModel: ->
    collection = @modelFor 'store-collections'
      .filterBy 'isNew', false
      .filterBy 'isDeleted', false
      .get 'firstObject'
    if collection
      @transitionTo 'store-objects', collection
    else
      @transitionTo 'store-collections.new'

`export default StoreCollectionsIndexRoute`
