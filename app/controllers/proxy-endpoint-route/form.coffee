`import FormController from 'gateway/controllers/form'`

ProxyEndpointRouteFormController = FormController.extend
  needs: ['proxy-endpoint-routes']
  modelType: 'proxy-endpoint-route'
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        routes = @get 'controllers.proxy-endpoint-routes.model'
        routes.pushObject model

`export default ProxyEndpointRouteFormController`
