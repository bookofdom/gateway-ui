`import BaseRemoteEndpointFormComponent from './base-remote-endpoint-form'`

RemoteEndpointFormComponent = BaseRemoteEndpointFormComponent.extend
  indexModel: null

  modelType: 'remote-endpoint'

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
    @_super.apply @, arguments

  actions:
    'delete-remote-endpoint-environment-datum': (model) ->
      model.deleteRecord()
    'new-remote-endpoint-environment-datum': ->
      @transitionToRoute 'remote-endpoint-environment-data.new'

`export default RemoteEndpointFormComponent`
