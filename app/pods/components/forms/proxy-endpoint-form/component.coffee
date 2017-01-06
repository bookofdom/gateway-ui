`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

ProxyEndpointFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'proxy-endpoint'

  savedAction: null

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
    prompt: false
    'new-resource-route': 'environments.new'
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
    prompt: false
    'new-resource-route': 'environments.new'
  ,
    name: 'endpoint_group'
    label: 'resources.endpoint-group'
    type: 'select-model-name'
  ]
  fields: Ember.computed 'model.isNew', ->
    if @get('model.isNew') then @get('newFields') else @get('editFields')

  createNewRouteModel: ->
    model = @get 'model'
    newRouteModel = @get('store').createRecord 'proxy-endpoint-route'
    model.get('routes').pushObject newRouteModel
  createNewChannelModel: ->
    model = @get 'model'
    newChannelModel = @get('store').createRecord 'proxy-endpoint-channel'
    model.get('channels').pushObject newChannelModel
  onInit: Ember.on 'init', ->
    @_super arguments...
    model = @get 'model'
    count = model?.get 'routes.length'
    isNew = model?.get 'isNew'
    # if an existing model has no routes, add one by default
    @createNewRouteModel() if model and !isNew and !count

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      proxyEndpoints = @get 'indexModel'
      proxyEndpoints.pushObject model
    model.get('channels').forEach (channel) ->
      if channel.get('hasDirtyAttributes') and !channel.get('isDeleted')
        channel.save()
    @_super arguments...

  cancel: ->
    @get('model.channels').forEach (channel) ->
      if channel.get('hasDirtyAttributes') and !channel.get('isDeleted')
        channel.cancel()
    @_super arguments...

  actions:
    'delete-proxy-endpoint-route': (record) -> record.deleteRecord()
    'new-proxy-endpoint-route': -> @createNewRouteModel()
    'delete-proxy-endpoint-channel': (record) -> record.deleteRecord()
    'new-proxy-endpoint-channel': -> @createNewChannelModel()

`export default ProxyEndpointFormComponent`
