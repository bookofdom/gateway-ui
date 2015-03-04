`import ProxyEndpointComponentCallFormController from 'gateway/controllers/proxy-endpoint-component-call/form'`

ProxyEndpointComponentCallInlineFormController = ProxyEndpointComponentCallFormController.extend
  'show-conditional-fields': false
  fields: Ember.computed 'show-conditional-fields', ->
    fields = 'remote_endpoint:resources.remote-endpoint::select-model-name,endpoint_name_override'
    if @get 'show-conditional-fields'
      fields = "#{fields},conditional:fields.call-conditional::javascript,conditional_positive"
    fields
  actions:
    'toggle-call': ->
      @set 'show-conditional-fields', !@get('show-conditional-fields')

`export default ProxyEndpointComponentCallInlineFormController`
