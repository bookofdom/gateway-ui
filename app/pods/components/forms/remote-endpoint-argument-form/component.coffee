`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

RemoteEndpointArgumentFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint-argument'

  fields: [
      name: 'value'
      required: true
    ]

`export default RemoteEndpointArgumentFormComponent`
