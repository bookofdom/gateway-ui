`import Ember from 'ember'`

ProxyEndpointTestsIndexController = Ember.Controller.extend
  'proxy-endpoint': Ember.inject.controller()
  routes: Ember.computed.alias 'proxy-endpoint.model.routes'

`export default ProxyEndpointTestsIndexController`
