`import BaseRemoteEndpointFormComponent from './base-remote-endpoint-form'`

RemoteEndpointFormComponent = BaseRemoteEndpointFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint'

  savedAction: null
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
    type: 'select'
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

`export default RemoteEndpointFormComponent`
