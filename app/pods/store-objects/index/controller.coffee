`import Ember from 'ember'`

StoreObjectsIndexController = Ember.Controller.extend
  store_collection: null
  fields: Ember.computed 'store_collection.common_keys', ->
    fields = @get('store_collection.common_keys')?.map (key) ->
      name: "json.#{key}"
      label: " #{key} " # to prevent i18n matches
      type: 'string'
    # always include ID column
    [{
      name: 'id'
      label: ' id ' # to prevent i18n matches
      type: 'string'
    }].concat fields

`export default StoreObjectsIndexController`
