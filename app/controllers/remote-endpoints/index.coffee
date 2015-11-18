`import Ember from 'ember'`

RemoteEndpointsIndexController = Ember.Controller.extend
  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'platformName'
    label: 'fields.type'
    type: 'string'
  ,
    name: 'location'
    label: 'fields.location'
    type: 'string'
  ,
    name: 'method'
    label: 'fields.method'
    type: 'string'
  ]

`export default RemoteEndpointsIndexController`
