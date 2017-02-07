`import Ember from 'ember'`

CustomFunctionsIndexController = Ember.Controller.extend
  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'active'
    label: 'fields.active'
    type: 'active-label'
  ]

`export default CustomFunctionsIndexController`
