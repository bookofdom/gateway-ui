`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

EnvironmentFormController = FormController.extend
  environments: Ember.inject.controller()
  modelType: 'environment'
  'option-groups': Ember.computed ->
    session_type: [
      name: t 'types.session.client'
      value: 'client'
    ,
      name: t 'types.session.server'
      value: 'server'
    ]
  newFields: [
    name: 'name'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ]
  editFields:
    client: [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'session_type'
      type: 'select'
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
    server: [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'session_type'
      type: 'select'
    ,
      name: 'session_name'
    ,
      name: 'session_header'
    ,
      name: 'show_javascript_errors'
      type: 'boolean'
    ]
  fields: Ember.computed 'model.isNew', 'model.session_type', ->
    if @get 'model.isNew'
      @get 'newFields'
    else
      type = @get 'model.session_type'
      @get "editFields.#{type}"
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
