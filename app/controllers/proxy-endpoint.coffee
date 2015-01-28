`import Ember from 'ember'`

ProxyEndpointController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default ProxyEndpointController`
