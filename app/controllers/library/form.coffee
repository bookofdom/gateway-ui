`import FormController from 'gateway/controllers/form'`

LibraryFormController = FormController.extend
  needs: ['libraries']
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
      type: 'javascript'
    ]
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        libraries = @get 'controllers.libraries.model'
        libraries.pushObject model

`export default LibraryFormController`
