`import Ember from 'ember'`

HostsIndexController = Ember.Controller.extend
  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ,
    name: 'hostname'
    type: 'string'
    label: 'fields.hostname'
  ]

`export default HostsIndexController`
