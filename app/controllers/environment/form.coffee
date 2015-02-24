`import FormController from 'gateway/controllers/form'`

EnvironmentFormController = FormController.extend
  needs: ['environments']
  modelType: 'environment'
  createNewVariableModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'environment-variable'
    model.get('variables').pushObject newModel
  actions:
    'delete-environment-variable': (record) -> record.deleteRecord()
    'new-environment-variable': -> @createNewVariableModel()
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        environments = @get 'controllers.environments.model'
        environments.pushObject model

`export default EnvironmentFormController`
