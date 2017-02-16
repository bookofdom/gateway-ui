`import Ember from 'ember'`

JobComponentCallsIndexController = Ember.Controller.extend
  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

  fields: [
    name: 'remote_endpoint.name'
    label: 'resources.remote-endpoint'
    type: 'string'
  ,
    name: 'endpoint_name_override'
    label: 'fields.endpoint_name_override'
    type: 'string'
  ]

`export default JobComponentCallsIndexController`
