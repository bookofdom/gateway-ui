`import EditController from 'gateway-ui/pods/edit/controller'`

ProxyEndpointRouteEditController = EditController.extend
  'proxy-endpoint-routes': Ember.inject.controller()
  indexModel: Ember.computed.alias 'proxy-endpoint-routes.model'

`export default ProxyEndpointRouteEditController`
