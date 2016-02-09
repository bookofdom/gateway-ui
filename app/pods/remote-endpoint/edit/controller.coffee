`import EditController from 'gateway/controllers/edit'`

RemoteEndpointEditController = EditController.extend
  'remote-endpoints/index': Ember.inject.controller()
  types: Ember.computed.alias 'remote-endpoints/index.types'
  actions:
    'new-remote-endpoint-environment-datum': ->
      @transitionToRoute 'remote-endpoint-environment-data.new'

`export default RemoteEndpointEditController`
