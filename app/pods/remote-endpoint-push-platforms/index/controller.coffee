`import Ember from 'ember'`

RemoteEndpointPushPlatformsIndexController = Ember.Controller.extend
  'remote-endpoint': Ember.inject.controller()
  parentModel: Ember.computed.alias 'remote-endpoint.model'

  fields: [
    name: 'platform.nameKey'
    label: 'fields.type'
    type: 't'
  ,
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ]

`export default RemoteEndpointPushPlatformsIndexController`
