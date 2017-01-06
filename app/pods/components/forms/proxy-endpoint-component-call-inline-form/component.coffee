`import ProxyEndpointComponentCallFormComponent from 'gateway-ui/pods/components/forms/proxy-endpoint-component-call-form/component'`

ProxyEndpointComponentCallInlineFormComponent = ProxyEndpointComponentCallFormComponent.extend
  embedded: true
  showConditionalFields: false

  fields: Ember.computed 'showConditionalFields', ->
    fields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
      'new-resource-route': 'remote-endpoints.new'
    ,
      name: 'endpoint_name_override'
    ]
    withConditionals = [
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      label: 'fields.call-conditional'
      type: 'javascript'
    ,
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
      'new-resource-route': 'remote-endpoints.new'
    ,
      name: 'endpoint_name_override'
    ]
    if @get 'showConditionalFields' then withConditionals else fields

  actions:
    'toggle-call': ->
      showConditionalFields = @get 'showConditionalFields'
      @set 'showConditionalFields', !showConditionalFields

`export default ProxyEndpointComponentCallInlineFormComponent`
