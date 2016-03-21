`import Ember from 'ember'`

StoreCollectionController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

`export default StoreCollectionController`
