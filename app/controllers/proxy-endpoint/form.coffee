`import FormController from 'gateway/controllers/form'`

ProxyEndpointFormController = FormController.extend
  needs: ['proxy-endpoints']
  modelType: 'proxy-endpoint'
  'option-groups': Ember.computed 'controllers.proxy-endpoints.environments', 'controllers.proxy-endpoints.endpoint_groups', ->
    environment: @get 'controllers.proxy-endpoints.environments'
    endpoint_group: @get 'controllers.proxy-endpoints.endpoint_groups'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    proxyEndpoints = @get 'controllers.proxy-endpoints.model'
    proxyEndpoints.pushObject newModel

`export default ProxyEndpointFormController`
