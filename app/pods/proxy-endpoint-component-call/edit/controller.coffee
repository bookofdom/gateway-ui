`import EditController from 'gateway/controllers/edit'`

ProxyEndpointComponentCallEditController = EditController.extend
  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'proxy-endpoint-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.option-groups'

`export default ProxyEndpointComponentCallEditController`
