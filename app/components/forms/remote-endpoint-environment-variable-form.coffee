`import BaseFormComponent from 'gateway/components/forms/base-form'`

RemoteEndpointEnvironmentVariableFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint-environment-variable'

  fields: [
    name: 'name'
    required: true
  ,
    name: 'value'
  ]

`export default RemoteEndpointEnvironmentVariableFormComponent`
