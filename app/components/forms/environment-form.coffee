`import BaseFormComponent from './base-form'`

EnvironmentFormComponent = BaseFormComponent.extend
  indexModel: null
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
  ,
    name: 'show_javascript_errors'
    type: 'boolean'
  ]

  createNewVariableModel: ->
    model = @get 'model'
    newModel = @get('store').createRecord 'environment-variable'
    model.get('variables').pushObject newModel

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      environments = @get 'indexModel'
      environments.pushObject model
    @_super.apply @, arguments

  actions:
    'delete-environment-variable': (record) -> record.deleteRecord()
    'new-environment-variable': -> @createNewVariableModel()

`export default EnvironmentFormComponent`
