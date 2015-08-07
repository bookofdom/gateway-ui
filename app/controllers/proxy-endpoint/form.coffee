`import FormController from 'gateway/controllers/form'`

ProxyEndpointFormController = FormController.extend
  needs: ['proxy-endpoints']
  modelType: 'proxy-endpoint'
  newFields: [
    name: 'name'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ,
    name: 'environment'
    label: 'resources.environment'
    type: 'select-model-name'
    required: true
  ,
    name: 'endpoint_group'
    label: 'resources.endpoint-group'
    type: 'select-model-name'
  ]
  editFields: [
    name: 'name'
    required: true
  ,
    name: 'active'
  ,
    name: 'cors_enabled'
  ,
    name: 'description'
    type: 'textarea'
  ,
    name: 'environment'
    label: 'resources.environment'
    type: 'select-model-name'
    required: true
  ,
    name: 'endpoint_group'
    label: 'resources.endpoint-group'
    type: 'select-model-name'
  ]
  fields: Ember.computed 'isNew', ->
    if @get('isNew') then @get('newFields') else @get('editFields')
  'option-groups': Ember.computed 'controllers.proxy-endpoints.environments.@each', 'controllers.proxy-endpoints.endpoint_groups.@each', ->
    environment: @get('controllers.proxy-endpoints.environments').filterBy 'isNew', false
    endpoint_group: @get('controllers.proxy-endpoints.endpoint_groups').filterBy 'isNew', false
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
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        proxyEndpoints = @get 'controllers.proxy-endpoints.model'
        proxyEndpoints.pushObject model
    afterDelete: ->
      @send 'deleted'

`export default ProxyEndpointFormController`
