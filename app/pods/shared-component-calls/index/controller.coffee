`import Ember from 'ember'`

SharedComponentCallsController = Ember.Controller.extend
  'shared-component': Ember.inject.controller()
  'shared-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'shared-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'shared-component-calls.option-groups'
  'transformation-option-groups': Ember.computed.alias 'shared-component-calls.transformation-option-groups'

  fields: [
    name: 'remote_endpoint.name'
    label: 'resources.remote-endpoint'
    type: 'string'
  ,
    name: 'endpoint_name_override'
    label: 'fields.endpoint_name_override'
    type: 'string'
  ]

`export default SharedComponentCallsController`
