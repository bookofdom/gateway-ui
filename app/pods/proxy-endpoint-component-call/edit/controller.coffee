`import ActionComponentCallEditController from 'gateway/pods/action-component-call/edit/controller'`

ProxyEndpointComponentCallEditController = ActionComponentCallEditController.extend
  prefix: 'proxy-endpoint'

  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'proxy-endpoint-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.option-groups'

  'transformation-option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.transformation-option-groups'

`export default ProxyEndpointComponentCallEditController`
