`import EditController from 'gateway/controllers/edit'`

LibraryEditController = EditController.extend
  'api': Ember.inject.controller()
  # Use preloaded api.libraries rather than libraries.model,
  # since libraries.model is filtered to remove internal libraries
  # which *should* be included in autocomplete.
  'option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'

`export default LibraryEditController`
