`import FormController from 'gateway/controllers/form'`

LibraryFormController = FormController.extend
  libraries: Ember.inject.controller()
  modelType: 'library'
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
