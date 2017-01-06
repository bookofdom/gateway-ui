`import Ember from 'ember'`
`import SharedComponent from 'gateway-ui/pods/shared-component/model'`

SharedComponentsIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()

  'option-groups': Ember.computed 'api.libraries', ->
    conditional: @get 'api.libraries'
    body: @get 'api.libraries'
    type: SharedComponent.types

  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ,
    name: 'typeName'
    type: 'string'
    label: 'fields.type'
  ]

`export default SharedComponentsIndexController`
