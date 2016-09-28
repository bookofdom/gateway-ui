`import ActionComponentCallsIndexController from 'gateway/pods/action-component-calls/index/controller'`

ProxyEndpointComponentCallsController = ActionComponentCallsIndexController.extend
  prefix: 'proxy-endpoint'
  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'proxy-endpoint-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.option-groups'

`export default ProxyEndpointComponentCallsController`
