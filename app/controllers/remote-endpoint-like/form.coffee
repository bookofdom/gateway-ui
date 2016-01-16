`import FormController from 'gateway/controllers/form'`
`import RemoteEndpointLike from '../../models/remote-endpoint-like'`
`import t from 'gateway/helpers/i18n'`
`import config from  '../../config/environment'`

RemoteEndpointLikeFormController = FormController.extend
  'remote-endpoints/index': Ember.inject.controller()

  types: Ember.computed.alias 'remote-endpoints/index.types'

  'option-groups': Ember.computed ->
    type: @get 'types'
    sslmode: RemoteEndpointLike.sslModes
    # TODO expose basic auth when available in backend
    auth_scheme: RemoteEndpointLike.authSchemes.filter (scheme) ->
      scheme.slug != 'basic'
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
    interpreter: RemoteEndpointLike.interpreters.filter (interpreter) ->
      if config.goOs
        interpreter.os == config.goOs
      else
        true

  platformFields: Ember.computed 'modelType', ->
    fields =
      http: [
        name: 'url'
      ,
        name: 'method'
        type: 'select'
      ]
      soap: [
        name: 'wsdl'
        type: 'file'
        required: true
      ,
        name: 'service_name'
        required: true
      ,
        name: 'url'
      ,
        name: 'auth_scheme'
        type: 'select'
      ,
        name: 'username'
      ,
        name: 'password'
        type: 'password'
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
      script: [
        name: 'interpreter'
        type: 'select'
        required: true
      ,
        name: 'timeout'
        label: 'fields.execution-timeout'
        type: 'integer'
      ,
        name: 'filepath'
      ,
        name: 'script'
        type: 'editor-text'
      ]
    # environment datum may not set WSDL
    fields.soap.shift() if @get('modelType') is 'remote-endpoint-environment-datum'
    fields

  fields: Ember.computed 'model.isNew', 'model.platform.slug', 'remote-endpoint.model.platform.slug', 'platformFields', ->
    fields = @_super.apply @, arguments
    platformSlug = @get('remote-endpoint.model.platform.slug') or @get('model.platform.slug')
    platformFields = @get "platformFields.#{platformSlug}"
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
    afterDelete: ->
      @send 'deleted'

`export default RemoteEndpointLikeFormController`
