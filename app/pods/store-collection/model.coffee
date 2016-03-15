`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

StoreCollection = Model.extend
  name: DS.attr 'string'

  # Relationships
  store_objects: DS.hasMany 'store-object', async: true

  # Computed
  common_keys: null
  objectsObserver: Ember.observer 'store_objects.content.@each.jsonKeys', ->
    @get('store_objects').then (objects) =>
      allKeys = []
      if objects.get('length') > 0
        allKeys = objects
          .map (obj) -> obj.get 'jsonKeys'
          .reduce (a, b) -> a.concat b
      uniqueKeys = allKeys.uniq()
      @set 'common_keys', uniqueKeys

`export default StoreCollection`
