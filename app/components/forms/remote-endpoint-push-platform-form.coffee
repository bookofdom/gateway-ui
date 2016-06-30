`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointPushPlatformFormComponent = BaseFormComponent.extend
  apiModel: null
  remoteEndpointModel: null
  indexModel: null
  modelType: 'remote-endpoint-push-platform'

  'option-groups':
    type: [
      name: t 'push-platforms.osx'
      value: 'osx'
    ,
      name: t 'push-platforms.ios'
      value: 'ios'
    ,
      name: t 'push-platforms.gcm'
      value: 'gcm'
    ,
      name: t 'push-platforms.mqtt'
      value: 'mqtt'
    ]

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
    apiName = @get 'apiModel.name'
    remoteEndpointCodename = @get 'remoteEndpointModel.codename'
    newModel.set 'apiName', apiName
    newModel.set 'remoteEndpointCodename', remoteEndpointCodename
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
