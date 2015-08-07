`import Ember from 'ember'`

ProxyEndpointTestController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default ProxyEndpointTestController`
