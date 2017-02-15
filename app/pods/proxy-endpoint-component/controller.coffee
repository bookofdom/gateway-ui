`import Ember from 'ember'`

ProxyEndpointComponentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.nameKey', -> @get 'model.nameKey'

`export default ProxyEndpointComponentController`
