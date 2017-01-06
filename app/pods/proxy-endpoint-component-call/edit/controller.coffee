`import EditController from 'gateway-ui/pods/edit/controller'`

ProxyEndpointComponentCallEditController = EditController.extend
  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'proxy-endpoint-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.option-groups'

  'transformation-option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.transformation-option-groups'

`export default ProxyEndpointComponentCallEditController`
