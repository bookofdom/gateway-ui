`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import RemoteEndpointPushPlatform from 'gateway/pods/remote-endpoint-push-platform/model'`

RemoteEndpointPushPlatformFormComponent = BaseFormComponent.extend
  remoteEndpointModel: null
  environmentDatumModel: null
  indexModel: null
  modelType: 'remote-endpoint-push-platform'

  'option-groups':
    type: RemoteEndpointPushPlatform.types

  defaultFields:
    [
      name: 'name'
      required: true
    ,
      name: 'codename'
      required: true
    ,
      name: 'type'
      required: true
      type: 'select'
    ]

  platformFields:
    osx: [
      name: 'certificate'
      type: 'file'
      required: true
    ,
      name: 'password'
      type: 'password'
    ,
      name: 'topic'
    ,
      name: 'development'
    ]
    ios: [
      name: 'certificate'
      type: 'file'
      required: true
    ,
      name: 'password'
      type: 'password'
    ,
      name: 'topic'
      required: true
    ,
      name: 'development'
    ]
    gcm: [
      name: 'api_key'
      required: true
    ]
    mqtt: [
      name: 'username'
      readonly: true
    ,
      name: 'password'
      type: 'password'
    ,
      name: 'connect_timeout'
      type: 'integer'
      required: true
    ,
      name: 'ack_timeout'
      type: 'integer'
      required: true
    ,
      name: 'timeout_retries'
      type: 'integer'
      required: true
    ]

  fields: Ember.computed 'model.type', ->
    fields = @_super arguments...
    type = @get 'model.type'
    platformFields = @get "platformFields.#{type}"
    fields = Ember.copy(fields).pushObjects platformFields if platformFields
    fields

  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @get('store')?.createRecord modelType
    remoteEndpointModel = @get 'remoteEndpointModel'
    environmentDatumModel = @get 'environmentDatumModel'
    newModel.set 'remoteEndpointModel', remoteEndpointModel
    newModel.set 'environmentDatumModel', environmentDatumModel
    @set 'model', newModel
    newModel

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pushPlatforms = @get 'indexModel'
      pushPlatforms.pushObject model
    @_super arguments...

  actions:
    cancel: ->
      @get('model').cancel().then =>
        @sendAction 'canceledAction'

`export default RemoteEndpointPushPlatformFormComponent`
