`import FormController from 'gateway/controllers/form'`

RemoteEndpointFormController = FormController.extend
  needs: ['remote-endpoints']
  modelType: 'remote-endpoint'
  'option-groups':
    type: [
      name: 'HTTP'
      value: 'http'
    ]
  createNewModel: ->
    newModel = @_super.apply @, arguments
    remoteEndpoints = @get 'controllers.remote-endpoints.model'
    remoteEndpoints.pushObject newModel

`export default RemoteEndpointFormController`
