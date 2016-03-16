`import Ember from 'ember'`

StoreObjectController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

`export default StoreObjectController`
