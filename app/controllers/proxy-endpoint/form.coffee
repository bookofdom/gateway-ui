`import FormController from 'gateway/controllers/form'`

ProxyEndpointFormController = FormController.extend
  needs: ['proxy-endpoints']
  modelType: 'proxy-endpoint'
  'option-groups': null
  createNewModel: ->
    newModel = @_super.apply @, arguments
    proxyEndpoints = @get 'controllers.proxy-endpoints.model'
    proxyEndpoints.pushObject newModel

`export default ProxyEndpointFormController`
