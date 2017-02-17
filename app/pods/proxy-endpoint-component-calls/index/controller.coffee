`import Ember from 'ember'`

ProxyEndpointComponentCallsController = Ember.Controller.extend
  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'proxy-endpoint-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'proxy-endpoint-component-calls.option-groups'

  fields: [
    name: 'remote_endpoint.name'
    label: 'resources.remote-endpoint'
    type: 'string'
  ,
    name: 'endpoint_name_override'
    label: 'fields.endpoint_name_override'
    type: 'string'
  ]

`export default ProxyEndpointComponentCallsController`
