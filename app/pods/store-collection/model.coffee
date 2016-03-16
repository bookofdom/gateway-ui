`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

StoreCollection = Model.extend
  name: DS.attr 'string'

  # Relationships
  store_objects: DS.hasMany 'store-object', async: true

  # Computed
  # Technically, you shouldn't have to compute on the content property.  Ember
  # is supposed to treat promise arrays as if they were regular arrays,
  # but it doesn't, and this may be a bug.  Thus, in order to detect new keys
  # added to existing objects, we must listen on content.  :'(
  common_keys: Ember.computed 'store_objects.@each.jsonKeys', 'store_objects.content.@each.jsonKeys', ->
    @get 'store_objects'
      .map (obj) -> obj.get 'jsonKeys'
      .reduce ((a, b) -> a.concat b), []
      .uniq()

`export default StoreCollection`
