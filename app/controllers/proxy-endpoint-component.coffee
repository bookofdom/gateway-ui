`import Ember from 'ember'`

ProxyEndpointComponentController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default ProxyEndpointComponentController`
