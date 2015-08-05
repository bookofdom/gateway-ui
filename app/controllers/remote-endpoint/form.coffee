`import FormController from 'gateway/controllers/form'`
`import RemoteEndpoint from '../../models/remote-endpoint'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointFormController = FormController.extend
  needs: ['remote-endpoints']
  modelType: 'remote-endpoint'

  'option-groups':
    type: RemoteEndpoint.types
    method: [
      name: t 'http-methods.get'
      value: 'GET'
    ,
      name: t 'http-methods.post'
      value: 'POST'
    ,
      name: t 'http-methods.put'
      value: 'PUT'
    ,
      name: t 'http-methods.delete'
      value: 'DELETE'
    ]

  defaultFields: [
    name: 'name'
    required: true
  ,
    name: 'codename'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ]

  newFields: [
    name: 'type'
    required: true
    type: 'select'
    help: t 'fields.help.remote-endpoint-type'
  ]

  platformFields:
    http: [
      name: 'url'
    ,
      name: 'method'
      type: 'select'
    ]
    sqlserver: [
      name: 'server'
      required: true
    ,
      name: 'port'
      type: 'integer'
      required: true
    ,
      name: 'username'
      required: true
    ,
      name: 'password'
      required: true
    ,
      name: 'database'
      required: true
    ,
      name: 'schema'
      required: true
    ,
      name: 'transactions'
    ,
      name: 'timeout'
      type: 'integer'
    ,
      name: 'maxidle'
      type: 'integer'
    ,
      name: 'maxopen'
      type: 'integer'
    ]
    postgres: [
      name: 'server'
      label: 'resources.host'
      required: true
    ,
      name: 'host_address'
      required: true
    ,
      name: 'port'
      type: 'integer'
      required: true
    ,
      name: 'database'
      required: true
    ,
      name: 'username'
      required: true
    ,
      name: 'password'
      required: true
    ,
      name: 'timeout'
      type: 'integer'
    ,
      name: 'transactions'
    ,
      name: 'maxidle'
      type: 'integer'
    ,
      name: 'maxopen'
      type: 'integer'
    ]

  fields: Ember.computed 'isNew', 'platform.slug', 'platformFields', ->
    fields = @_super.apply @, arguments
    platformFields = @get "platformFields.#{@get 'platform.slug'}"
    fields = Ember.copy(fields).pushObjects platformFields if platformFields
    fields

  createNewHeaderModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'remote-endpoint-header'
    model.get('headers').pushObject newModel
  createNewQueryParameterModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'remote-endpoint-query-parameter'
    model.get('query').pushObject newModel
  actions:
    'delete-remote-endpoint-header': (record) -> record.deleteRecord()
    'new-remote-endpoint-header': -> @createNewHeaderModel()
    'delete-remote-endpoint-query-parameter': (record) -> record.deleteRecord()
    'new-remote-endpoint-query-parameter': -> @createNewQueryParameterModel()
    'delete-remote-endpoint-environment-datum': (record) ->
      record.deleteRecord()
    'new-remote-endpoint-environment-datum': ->
      @transitionToRoute 'remote-endpoint-environment-data.new'
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        remoteEndpoints = @get 'controllers.remote-endpoints.model'
        remoteEndpoints.pushObject model

`export default RemoteEndpointFormController`
