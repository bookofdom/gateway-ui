`import FormController from 'gateway/controllers/form'`

RemoteEndpointEnvironmentDatumFormController = FormController.extend
  needs: ['remote-endpoint-environment-data']
  modelType: 'remote-endpoint-environment-datum'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    environments = @get 'controllers.remote-endpoint-environment-data.model'
    environments.pushObject newModel

`export default RemoteEndpointEnvironmentDatumFormController`
