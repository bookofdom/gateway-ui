`import ProxyEndpointComponentCallFormComponent from './proxy-endpoint-component-call-form'`
`import InlineFormMixin from 'gateway/mixins/inline-form'`

ProxyEndpointComponentCallInlineFormComponent = ProxyEndpointComponentCallFormComponent.extend InlineFormMixin,
  'show-conditional-fields': false
  fields: Ember.computed 'show-conditional-fields', ->
    fields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
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
    ,
      name: 'endpoint_name_override'
    ]
    if @get 'show-conditional-fields' then withConditionals else fields

`export default ProxyEndpointComponentCallInlineFormComponent`
