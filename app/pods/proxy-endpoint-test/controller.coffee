`import Ember from 'ember'`

ProxyEndpointTestController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ProxyEndpointTestController`
