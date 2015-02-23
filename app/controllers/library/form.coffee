`import FormController from 'gateway/controllers/form'`

LibraryFormController = FormController.extend
  needs: ['libraries']
  modelType: 'library'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    libraries = @get 'controllers.libraries.model'
    libraries.pushObject newModel

`export default LibraryFormController`
