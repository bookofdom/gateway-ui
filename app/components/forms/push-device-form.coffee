`import BaseFormComponent from 'gateway/components/forms/base-form'`

PushDeviceFormComponent = BaseFormComponent.extend
  savedAction: null
  modelType: 'push-device'

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
  ]

`export default PushDeviceFormComponent`
