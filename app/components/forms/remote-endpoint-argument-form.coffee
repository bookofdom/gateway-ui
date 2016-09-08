`import BaseFormComponent from 'gateway/components/forms/base-form'`

RemoteEndpointArgumentFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint-argument'

  fields: [
      name: 'value'
      required: true
    ]

`export default RemoteEndpointArgumentFormComponent`
