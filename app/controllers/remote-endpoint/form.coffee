`import FormController from 'gateway/controllers/form'`
`import RemoteEndpoint from '../../models/remote-endpoint'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointFormController = FormController.extend
  'remote-endpoints': Ember.inject.controller()
  modelType: 'remote-endpoint'

  'option-groups':
    type: RemoteEndpoint.types
    sslmode: RemoteEndpoint.sslModes
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
      type: 'password'
      required: true
    ,
      name: 'database'
      required: true
    ,
      name: 'schema'
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
      type: 'password'
      required: true
    ,
      name: 'sslmode'
      type: 'select'
    ,
      name: 'transactions'
    ,
      name: 'maxidle'
      type: 'integer'
    ,
      name: 'maxopen'
      type: 'integer'
    ]
    mysql: [
      name: 'server'
      label: 'resources.host'
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
      type: 'password'
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
    mongodb: [
      name: 'database'
      required: true
    ,
      name: 'username'
      required: true
    ,
      name: 'password'
      type: 'password'
      required: true
    ,
      name: 'limit'
      type: 'integer'
      required: true
    ]

  fields: Ember.computed 'model.isNew', 'model.platform.slug', 'platformFields', ->
    fields = @_super.apply @, arguments
    platformFields = @get "platformFields.#{@get 'model.platform.slug'}"
    fields = Ember.copy(fields).pushObjects platformFields if platformFields
    fields

  addHostModel: Ember.observer 'model.isMongo', ->
    @_super.apply @, arguments
    model = @get 'model'
    if model
      isHostsEmpty = !model.get 'hosts.length'
      isNew = model.get 'isNew'
      isMongo = model.get 'isMongo'
      # if an existing model has no hosts, add one by default
      @createNewHostModel() if isNew and isMongo and isHostsEmpty
  createNewHeaderModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'remote-endpoint-header'
    model.get('headers').pushObject newModel
  createNewQueryParameterModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'remote-endpoint-query-parameter'
    model.get('query').pushObject newModel
  createNewHostModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'remote-endpoint-host'
    model.get('hosts').pushObject newModel
  actions:
    'delete-remote-endpoint-header': (record) -> record.deleteRecord()
    'new-remote-endpoint-header': -> @createNewHeaderModel()
    'delete-remote-endpoint-query-parameter': (record) -> record.deleteRecord()
    'new-remote-endpoint-query-parameter': -> @createNewQueryParameterModel()
    'delete-remote-endpoint-host': (record) -> record.deleteRecord()
    'new-remote-endpoint-host': -> @createNewHostModel()
    'delete-remote-endpoint-environment-datum': (record) ->
      record.deleteRecord()
    'new-remote-endpoint-environment-datum': ->
      @transitionToRoute 'remote-endpoint-environment-data.new'
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        remoteEndpoints = @get 'remote-endpoints.model'
        remoteEndpoints.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default RemoteEndpointFormController`
