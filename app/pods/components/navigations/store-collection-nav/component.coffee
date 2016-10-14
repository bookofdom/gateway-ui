`import Ember from 'ember'`

NavigationsStoreCollectionNavComponent = Ember.Component.extend
  data: null
  store_collections: Ember.computed.alias 'data'

`export default NavigationsStoreCollectionNavComponent`
