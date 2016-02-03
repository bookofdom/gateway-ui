`import EditController from 'gateway/controllers/edit'`

RemoteEndpointEditController = EditController.extend
  'remote-endpoints/index': Ember.inject.controller()
  types: Ember.computed.alias 'remote-endpoints/index.types'

`export default RemoteEndpointEditController`
