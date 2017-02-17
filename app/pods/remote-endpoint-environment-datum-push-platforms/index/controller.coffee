`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumPushPlatformsIndexController = Ember.Controller.extend
  'remote-endpoint-environment-datum': Ember.inject.controller()
  parentModel: Ember.computed.alias 'remote-endpoint-environment-datum.model'

  fields: [
    name: 'platform.nameKey'
    label: 'fields.type'
    type: 't'
  ,
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ]

`export default RemoteEndpointEnvironmentDatumPushPlatformsIndexController`
