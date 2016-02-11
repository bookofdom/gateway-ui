`import Ember from 'ember'`

SharedComponentsIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()

  'option-groups': Ember.computed 'api.libraries', ->
    conditional: @get 'api.libraries'
    body: @get 'api.libraries'

  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ]

`export default SharedComponentsIndexController`
