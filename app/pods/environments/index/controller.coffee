`import Ember from 'ember'`

EnvironmentsIndexController = Ember.Controller.extend
  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ,
    name: 'description'
    type: 'string'
    label: 'fields.description'
  ]

`export default EnvironmentsIndexController`
