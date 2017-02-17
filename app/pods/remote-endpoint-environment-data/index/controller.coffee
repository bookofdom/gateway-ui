`import Ember from 'ember'`

RemoteEndpointEnvironmentDataIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()
  'remote-endpoint': Ember.inject.controller()

  environments: Ember.computed.alias 'api.environments'
  remoteEndpointType: Ember.computed.alias 'remote-endpoint.model.type'

  fields: [
    name: 'environment.name'
    label: 'resources.environment'
    type: 'string'
  ,
    name: 'url'
    label: 'fields.url'
    type: 'string'
  ,
    name: 'method'
    label: 'fields.method'
    type: 'string'
  ]

`export default RemoteEndpointEnvironmentDataIndexController`
