`import Ember from 'ember'`

ProxyEndpointTestsIndexController = Ember.Controller.extend
  'proxy-endpoint': Ember.inject.controller()
  routes: Ember.computed.alias 'proxy-endpoint.model.routes'
  channels: Ember.computed.alias 'proxy-endpoint.model.channels'

  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ,
    name: 'methodType.name'
    type: 'string'
    label: 'fields.method'
  ,
    name: 'channel.full_name'
    type: 'string'
    label: 'resources.proxy-endpoint-channel'
  ,
    name: 'route'
    type: 'string'
    label: 'resources.proxy-endpoint-route'
  ]

`export default ProxyEndpointTestsIndexController`
