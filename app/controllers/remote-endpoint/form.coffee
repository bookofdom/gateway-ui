`import FormController from 'gateway/controllers/form'`

RemoteEndpointFormController = FormController.extend
  needs: ['remote-endpoints']
  modelType: 'remote-endpoint'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    remoteEndpoints = @get 'controllers.remote-endpoints.model'
    remoteEndpoints.pushObject newModel
  createNewEnvironmentDatumModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'remote-endpoint-environment-datum'
    model.get('environment_data').pushObject newModel
  onInit: Ember.on 'init', ->
    @_super.apply @, arguments
    model = @get 'model'
    count = model?.get 'environment_data.length'
    isNew = model?.get 'isNew'
    # if an existing model has no environment datum, add one by default
    @createNewEnvironmentDatumModel() if model and !isNew and !count
  actions:
    'delete-remote-endpoint-environment-datum': (record) ->
      record.deleteRecord()
    'new-remote-endpoint-environment-datum': ->
      @createNewEnvironmentDatumModel()

`export default RemoteEndpointFormController`
