`import FormController from 'gateway/controllers/form'`

LibraryFormController = FormController.extend
  'api': Ember.inject.controller()
  libraries: Ember.inject.controller()
  modelType: 'library'
  # Use preloaded api.libraries rather than libraries.model,
  # since libraries.model is filtered to remove internal libraries
  # which *should* be included in autocomplete.
  'option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'body'
      label: 'fields.logic'
      type: 'javascript-lg'
    ]
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        libraries = @get 'libraries.model'
        libraries.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default LibraryFormController`
