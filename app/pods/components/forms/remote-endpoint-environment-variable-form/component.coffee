`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

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
