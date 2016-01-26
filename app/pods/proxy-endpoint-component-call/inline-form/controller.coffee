`import ProxyEndpointComponentCallFormController from 'gateway/pods/proxy-endpoint-component-call/form/controller'`

ProxyEndpointComponentCallInlineFormController = ProxyEndpointComponentCallFormController.extend
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
  actions:
    'toggle-call': ->
      @set 'show-conditional-fields', !@get('show-conditional-fields')

`export default ProxyEndpointComponentCallInlineFormController`
