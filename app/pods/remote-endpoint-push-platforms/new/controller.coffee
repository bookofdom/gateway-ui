`import Ember from 'ember'`

RemoteEndpointPushPlatformsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint': Ember.inject.controller()

  parentModel: Ember.computed.alias 'remote-endpoint.model'

`export default RemoteEndpointPushPlatformsNewController`
