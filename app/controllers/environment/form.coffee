`import FormController from 'gateway/controllers/form'`

EnvironmentFormController = FormController.extend
  environments: Ember.inject.controller()
  modelType: 'environment'
  newFields: [
    name: 'name'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ]
  editFields: [
    name: 'name'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ,
    name: 'session_name'
  ,
    name: 'session_auth_key'
  ,
    name: 'session_encryption_key'
    type: 'textarea'
  ,
    name: 'session_auth_key_rotate'
  ,
    name: 'session_encryption_key_rotate'
    type: 'textarea'
  ]
  fields: Ember.computed 'model.isNew', ->
    if @get 'model.isNew' then @get 'newFields' else @get 'editFields'
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
        environments = @get 'environments.model'
        environments.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default EnvironmentFormController`
