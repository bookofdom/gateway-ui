`import FormController from 'gateway/controllers/form'`

ProxyEndpointRouteFormController = FormController.extend
  'proxy-endpoint-routes': Ember.inject.controller()
  modelType: 'proxy-endpoint-route'
  fields: Ember.computed ->
    [
      name: 'path'
      required: true
    ,
      name: 'methods'
      type: 'methods'
    ]
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        routes = @get 'proxy-endpoint-routes.model'
        routes.pushObject model

`export default ProxyEndpointRouteFormController`
