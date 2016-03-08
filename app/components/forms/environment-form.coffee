`import t from 'gateway/helpers/i18n'`
`import BaseFormComponent from './base-form'`

EnvironmentFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'environment'

  'option-groups': Ember.computed ->
    session_type: [
      name: t 'types.session.client'
      value: 'client'
    ,
      name: t 'types.session.server'
      value: 'server'
    ]

  savedAction: null

  newFields: [
    name: 'name'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ]
  sessionTypeFields:
    client: [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'show_javascript_errors'
      type: 'boolean'
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
    ]
    server: [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'show_javascript_errors'
      type: 'boolean'
    ,
      name: 'session_type'
      type: 'select'
    ,
      name: 'session_name'
    ,
      name: 'session_header'
    ]
  editFields: Ember.computed 'model.session_type', ->
    type = @get 'model.session_type'
    @get "sessionTypeFields.#{type}"

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
