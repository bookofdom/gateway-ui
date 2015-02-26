`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointEnvironmentDatumFormController = FormController.extend
  needs: ['remote-endpoints', 'remote-endpoint-environment-data']
  modelType: 'remote-endpoint-environment-datum'
  'option-groups': Ember.computed 'controllers.remote-endpoints.environments.@each', ->
    environment: @get('controllers.remote-endpoints.environments').filterBy 'isNew', false
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
        environmentData = @get 'controllers.remote-endpoint-environment-data.model'
        environmentData.pushObject model

`export default RemoteEndpointEnvironmentDatumFormController`
