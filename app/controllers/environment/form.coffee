`import FormController from 'gateway/controllers/form'`

EnvironmentFormController = FormController.extend
  needs: ['environments']
  modelType: 'environment'
  fields: Ember.computed 'isNew', ->
    baseFields = 'name,description:::textarea'
    if @get 'isNew'
      baseFields
    else
      "#{baseFields},session_name,session_auth_key,session_encryption_key:::textarea,session_auth_key_rotate,session_encryption_key_rotate:::textarea"
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
