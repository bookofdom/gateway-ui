`import FormController from 'gateway/controllers/form'`

ProxyEndpointRouteFormController = FormController.extend
  needs: ['proxy-endpoint-routes']
  modelType: 'proxy-endpoint-route'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    environments = @get 'controllers.proxy-endpoint-routes.model'
    environments.pushObject newModel

`export default ProxyEndpointRouteFormController`
