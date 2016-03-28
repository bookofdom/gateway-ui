`import BaseFormComponent from 'gateway/components/forms/base-form'`

RemoteEndpointHostFormComponent = BaseFormComponent.extend
  fields: [
    name: 'host'
    required: true
  ,
    name: 'port'
    type: 'integer'
    required: true
  ]

`export default RemoteEndpointHostFormComponent`
