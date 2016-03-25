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

  fields:
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

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pushPlatforms = @get 'indexModel'
      pushPlatforms.pushObject model
    @_super arguments...

`export default RemoteEndpointPushPlatformFormComponent`
