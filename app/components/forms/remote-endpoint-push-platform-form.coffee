`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointPushPlatformFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint-push-platform'

  savedAction: null

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

`export default RemoteEndpointPushPlatformFormComponent`
