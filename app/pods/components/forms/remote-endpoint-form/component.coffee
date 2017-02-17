`import BaseRemoteEndpointFormComponent from 'gateway-ui/pods/components/forms/base-remote-endpoint-form/component'`

RemoteEndpointFormComponent = BaseRemoteEndpointFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint'

  #savedAction: null
  newDatumAction: 'new-remote-endpoint-environment-datum'

  defaultFields: [
    name: 'name'
    required: true
  ,
    name: 'codename'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ]

  newFields: [
    name: 'type'
    required: true
    type: 'select-name-key'
  ]

  environmentDataTableFields: [
    name: 'environment.name'
    label: 'resources.environment'
    type: 'string'
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

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      indexModel = @get 'indexModel'
      indexModel.pushObject model
    @_super arguments...

  actions:
    'delete-remote-endpoint-environment-datum': (model) ->
      model.deleteRecord()
    'new-remote-endpoint-environment-datum': ->
      @sendAction 'newDatumAction'
    saved: ->
      @send 'saved'

`export default RemoteEndpointFormComponent`
