`import Ember from 'ember'`
`import FormController from 'gateway/controllers/form'`

EnvironmentFormController = FormController.extend
  needs: ['environments']
  modelType: 'environment'
  createNewModel: ->
    environments = @get 'controllers.environments.model'
    newModel = @_super.apply @, arguments
    environments.pushObject newModel

`export default EnvironmentFormController`
