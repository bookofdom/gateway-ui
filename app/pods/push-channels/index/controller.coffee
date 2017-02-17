`import Ember from 'ember'`

PushChannelsIndexController = Ember.Controller.extend
  'push': Ember.inject.controller()
  'apis': Ember.computed.alias 'push.apis'

  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'expires'
    label: 'fields.expires'
    type: 'datetime'
  ,
    name: 'api.name'
    label: 'resources.api'
    type: 'string'
  ,
    name: 'remote_endpoint.name'
    label: 'resources.remote-endpoint'
    type: 'string'
  ]

`export default PushChannelsIndexController`
