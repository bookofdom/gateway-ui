`import FormController from 'gateway/controllers/form'`

EnvironmentFormController = FormController.extend
  needs: ['environments']
  modelType: 'environment'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    environments = @get 'controllers.environments.model'
    environments.pushObject newModel

`export default EnvironmentFormController`
