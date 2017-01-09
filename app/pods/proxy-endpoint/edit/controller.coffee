`import EditController from 'gateway-ui/pods/edit/controller'`

ProxyEndpointEditController = EditController.extend
  'proxy-endpoints': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'proxy-endpoints.option-groups'

`export default ProxyEndpointEditController`
