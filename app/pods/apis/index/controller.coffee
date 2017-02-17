`import Ember from 'ember'`

ApisIndexController = Ember.Controller.extend
  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'base_url'
    label: 'fields.base_url'
    type: 'string'
  ,
    name: 'description'
    label: 'fields.description'
    type: 'string'
  ]

`export default ApisIndexController`
