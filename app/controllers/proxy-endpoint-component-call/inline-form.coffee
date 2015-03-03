`import ProxyEndpointComponentCallFormController from 'gateway/controllers/proxy-endpoint-component-call/form'`

ProxyEndpointComponentCallInlineFormController = ProxyEndpointComponentCallFormController.extend
  fields: Ember.computed ->
    'remote_endpoint:resources.remote-endpoint::select-model-name,endpoint_name_override,conditional:fields.call_conditional::javascript,conditional_positive'

`export default ProxyEndpointComponentCallInlineFormController`
