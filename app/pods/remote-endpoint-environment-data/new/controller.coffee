`import Ember from 'ember'`

RemoteEndpointEnvironmentDataNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint-environment-data': Ember.inject.controller()

  indexModel: Ember.computed.alias 'remote-endpoint-environment-data.model'
  environments: Ember.computed.alias 'remote-endpoint-environment-data.environments'
  remoteEndpointType: Ember.computed.alias 'remote-endpoint-environment-data.remoteEndpointType'

`export default RemoteEndpointEnvironmentDataNewController`
