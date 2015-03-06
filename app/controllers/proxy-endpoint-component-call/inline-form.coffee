`import ProxyEndpointComponentCallFormController from 'gateway/controllers/proxy-endpoint-component-call/form'`

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
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ,
      name: 'conditional'
      label: 'fields.call-conditional'
      type: 'javascript'
    ,
      name: 'conditional_positive'
    ]
    if @get 'show-conditional-fields' then withConditionals else fields
  actions:
    'toggle-call': ->
      @set 'show-conditional-fields', !@get('show-conditional-fields')

`export default ProxyEndpointComponentCallInlineFormController`
