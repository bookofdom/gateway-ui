`import EditController from 'gateway/controllers/edit'`

ProxyEndpointRouteEditController = EditController.extend
  'proxy-endpoint-routes': Ember.inject.controller()
  indexModel: Ember.computed.alias 'proxy-endpoint-routes.model'

`export default ProxyEndpointRouteEditController`
