`import FormController from 'gateway/controllers/form'`

EnvironmentFormController = FormController.extend
  needs: ['environments']
  modelType: 'environment'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    environments = @get 'controllers.environments.model'
    environments.pushObject newModel
  createNewVariableModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'environment-variable'
    model.get('variables').pushObject newModel
  actions:
    'delete-environment-variable': (record) -> record.deleteRecord()
    'new-environment-variable': -> @createNewVariableModel()

`export default EnvironmentFormController`
