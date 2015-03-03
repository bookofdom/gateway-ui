`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentCallFormController = FormController.extend
  needs: ['proxy-endpoints']
  'option-groups': Ember.computed 'controllers.proxy-endpoints.remote_endpoints.@each', ->
    remote_endpoint: @get('controllers.proxy-endpoints.remote_endpoints').filterBy 'isNew', false
  fields: Ember.computed 'isNew', ->
    fields = 'remote_endpoint:resources.remote-endpoint::select-model-name,endpoint_name_override,conditional:fields.call_conditional::javascript,conditional_positive'
    fields

`export default ProxyEndpointComponentCallFormController`
