`import Ember from 'ember'`

LibrariesIndexController = Ember.Controller.extend
  filtered: Ember.computed 'model.[]', ->
    model = @get 'model'
    model.filter (library) -> !library.get 'internal'

  'api': Ember.inject.controller()
  # Use preloaded api.libraries rather than libraries.model,
  # since libraries.model is filtered to remove internal libraries
  # which *should* be included in autocomplete.
  'option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'

  fields: [
    name: 'name'
    type: 'string'
    label: 'fields.name'
  ,
    name: 'description'
    type: 'string'
    label: 'fields.description'
  ]

`export default LibrariesIndexController`
