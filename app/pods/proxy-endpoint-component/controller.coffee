`import Ember from 'ember'`

ProxyEndpointComponentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ProxyEndpointComponentController`
