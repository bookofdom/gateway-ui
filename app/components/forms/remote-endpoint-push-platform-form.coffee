`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import RemoteEndpointPushPlatform from 'gateway/pods/remote-endpoint-push-platform/model'`

RemoteEndpointPushPlatformFormComponent = BaseFormComponent.extend
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
    ,
      name: 'development'
    ]
    gcm: [
      name: 'api_key'
      required: true
    ]

  fields: Ember.computed 'model.type', ->
    fields = @_super arguments...
    type = @get 'model.type'
    platformFields = @get "platformFields.#{type}"
    fields = Ember.copy(fields).pushObjects platformFields if platformFields
    fields

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
