`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

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
