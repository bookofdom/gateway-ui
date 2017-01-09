`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

PushChannelDeviceFormComponent = BaseFormComponent.extend
  savedAction: null
  indexModel: null
  modelType: 'push-channel-device'

  defaultFields: [
      name: 'name'
      required: true
    ,
      name: 'type'
      type: 'select'
      required: true
    ,
      name: 'token'
      required: true
    ,
      name: 'expires'
      type: 'datetime'
      required: true
    ,
      name: 'qos'
      type: 'integer'
      required: true
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pushDevices = @get 'indexModel'
      pushDevices.pushObject model
    @_super arguments...

`export default PushChannelDeviceFormComponent`
