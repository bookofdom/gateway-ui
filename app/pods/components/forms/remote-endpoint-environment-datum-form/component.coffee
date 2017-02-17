`import BaseRemoteEndpointFormComponent from 'gateway-ui/pods/components/forms/base-remote-endpoint-form/component'`

RemoteEndpointEnvironmentDatumFormComponent = BaseRemoteEndpointFormComponent.extend
  indexModel: null
  environments: null
  remoteEndpointType: null
  modelType: 'remote-endpoint-environment-datum'

  newPadAction: 'new-remote-endpoint-environment-datum-scratch-pad'

  'option-groups': Ember.computed 'environments.@each.isNew', ->
    Ember.merge @_super(arguments...),
      environment: @get('environments').filterBy 'isNew', false

  defaultFields: [
    name: 'environment'
    label: 'resources.environment'
    type: 'select-model-name'
    required: true
  ]

  pushPlatformTableFields: [
    name: 'platform.nameKey'
    label: 'fields.type'
    type: 't'
  ,
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ]
  scratchPadTableFields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ]

  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @get('store')?.createRecord modelType
    remoteEndpointType = @get 'remoteEndpointType'
    newModel.set 'type', remoteEndpointType
    @set 'model', newModel
    newModel

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      indexModel = @get 'indexModel'
      indexModel.pushObject model
    @_super arguments...

  actions:
    saved: ->
      @notifySaveSuccess()
      # resend this action
      # so that the router can handle it if necessary
      @sendAction 'savedAction'
    'new-remote-endpoint-environment-datum-scratch-pad': ->
      @sendAction 'newPadAction'

`export default RemoteEndpointEnvironmentDatumFormComponent`
