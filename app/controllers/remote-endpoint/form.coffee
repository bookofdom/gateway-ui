`import RemoteEndpointLikeFormController from '../remote-endpoint-like/form'`

RemoteEndpointFormController = RemoteEndpointLikeFormController.extend
  'remote-endpoints': Ember.inject.controller()
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

  actions:
    'delete-remote-endpoint-environment-datum': (record) ->
      record.deleteRecord()
    'new-remote-endpoint-environment-datum': ->
      @transitionToRoute 'remote-endpoint-environment-data.new'
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        remoteEndpoints = @get 'remote-endpoints.model'
        remoteEndpoints.pushObject model

`export default RemoteEndpointFormController`
