`import ProxyEndpointComponentCallFormController from 'gateway/controllers/proxy-endpoint-component-call/form'`

ProxyEndpointComponentCallInlineTabularFormController = ProxyEndpointComponentCallFormController.extend
  fields: Ember.computed ->
    'remote_endpoint:resources.remote-endpoint::select-model-name,endpoint_name_override'

`export default ProxyEndpointComponentCallInlineTabularFormController`
