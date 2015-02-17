`import FormController from 'gateway/controllers/form'`

ProxyEndpointFormController = FormController.extend
  needs: ['proxy-endpoints']
  modelType: 'proxy-endpoint'
  newFields: 'name,description:::textarea,environment:resources.environment::select-model-name,endpoint_group:resources.endpoint-group::select-model-name'
  editFields: 'name,active,cors_enabled,description:::textarea,environment:resources.environment::select-model-name,endpoint_group:resources.endpoint-group::select-model-name'
  fields: Ember.computed 'isNew', ->
    if @get('isNew') then @get('newFields') else @get('editFields')
  'option-groups': Ember.computed 'controllers.proxy-endpoints.environments', 'controllers.proxy-endpoints.endpoint_groups', ->
    environment: @get 'controllers.proxy-endpoints.environments'
    endpoint_group: @get 'controllers.proxy-endpoints.endpoint_groups'
  createNewModel: ->
    newModel = @_super.apply @, arguments
    proxyEndpoints = @get 'controllers.proxy-endpoints.model'
    proxyEndpoints.pushObject newModel
  createNewRouteModel: ->
    model = @get 'model'
    newRouteModel = @store?.createRecord 'proxy-endpoint-route'
    model.get('routes').pushObject newRouteModel
  onInit: Ember.on 'init', ->
    @_super.apply @, arguments
    model = @get 'model'
    count = model?.get 'routes.length'
    isNew = model?.get 'isNew'
    # if an existing model has no routes, add one by default
    @createNewRouteModel() if model and !isNew and !count
  actions:
    'delete-proxy-endpoint-route': (record) -> record.deleteRecord()
    'new-proxy-endpoint-route': -> @createNewRouteModel()

`export default ProxyEndpointFormController`
