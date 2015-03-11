`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointFormController = FormController.extend
  needs: ['remote-endpoints']
  modelType: 'remote-endpoint'
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'codename'
    ,
      name: 'url'
    ,
      name: 'method'
      type: 'select'
    ,
      name: 'description'
      type: 'textarea'
    ]
  'option-groups':
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
