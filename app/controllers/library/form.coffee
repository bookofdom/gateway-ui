`import FormController from 'gateway/controllers/form'`

LibraryFormController = FormController.extend
  needs: ['libraries']
  modelType: 'library'
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        libraries = @get 'controllers.libraries.model'
        libraries.pushObject model

`export default LibraryFormController`
