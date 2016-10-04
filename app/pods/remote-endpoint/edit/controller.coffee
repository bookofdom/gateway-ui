`import EditController from 'gateway/pods/edit/controller'`

RemoteEndpointEditController = EditController.extend
  'remote-endpoints/index': Ember.inject.controller()
  types: Ember.computed.alias 'remote-endpoints/index.types'

`export default RemoteEndpointEditController`
