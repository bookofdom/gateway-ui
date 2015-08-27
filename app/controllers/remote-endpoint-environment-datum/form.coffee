`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointEnvironmentDatumFormController = FormController.extend
  'api': Ember.inject.controller()
  'remote-endpoint-environment-data': Ember.inject.controller()
  modelType: 'remote-endpoint-environment-datum'
  fields: Ember.computed ->
    [
      name: 'environment'
      label: 'resources.environment'
      type: 'select-model-name'
      required: true
    ,
      name: 'url'
    ,
      name: 'method'
      type: 'select'
    ]
  'option-groups': Ember.computed 'api.environments.@each.isNew', ->
    environment: @get('api.environments').filterBy 'isNew', false
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
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        environmentData = @get 'remote-endpoint-environment-data.model'
        environmentData.pushObject model
    afterSave: ->
      @notifySaveSuccess()
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'
    afterDelete: ->
      @send 'deleted'

`export default RemoteEndpointEnvironmentDatumFormController`
