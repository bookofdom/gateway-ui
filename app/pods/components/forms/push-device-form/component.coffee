`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

PushDeviceFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'push-device'

  'show-delete': false

  defaultFields: [
      name: 'name'
      required: true
      disabled: true
    ,
      name: 'type'
      type: 'select'
      required: true
      disabled: true
    ,
      name: 'token'
      required: true
      disabled: true
  ]

`export default PushDeviceFormComponent`
