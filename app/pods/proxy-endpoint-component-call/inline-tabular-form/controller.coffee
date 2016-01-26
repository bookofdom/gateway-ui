`import ProxyEndpointComponentCallFormController from 'gateway/pods/proxy-endpoint-component-call/form/controller'`

ProxyEndpointComponentCallInlineTabularFormController = ProxyEndpointComponentCallFormController.extend
  fields: [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ]

`export default ProxyEndpointComponentCallInlineTabularFormController`
