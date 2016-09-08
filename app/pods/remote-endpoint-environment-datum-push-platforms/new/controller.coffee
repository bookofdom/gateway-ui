`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumPushPlatformsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint-environment-datum': Ember.inject.controller()

  parentModel: Ember.computed.alias 'remote-endpoint-environment-datum.model'

`export default RemoteEndpointEnvironmentDatumPushPlatformsNewController`
