`import ProxyEndpointComponentCallFormController from 'gateway/controllers/proxy-endpoint-component-call/form'`

ProxyEndpointComponentCallInlineTabularFormController = ProxyEndpointComponentCallFormController.extend
  fields: Ember.computed ->
    fields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ]

`export default ProxyEndpointComponentCallInlineTabularFormController`
