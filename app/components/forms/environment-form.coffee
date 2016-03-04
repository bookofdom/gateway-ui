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
  editFields: [
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
  ]
  sessionTypeFields:
    client: [
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
      name: 'session_header'
    ]
  fields: Ember.computed 'model.isNew', 'model.session_type', ->
    fields = @_super.apply @, arguments
    unless @get 'model.isNew'
      type = @get 'model.session_type'
      sessionTypeFields = @get "sessionTypeFields.#{type}"
      fields = Ember.copy(fields).pushObjects sessionTypeFields
    fields

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
