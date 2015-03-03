`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentCallFormController = FormController.extend
  needs: ['proxy-endpoints', 'proxy-endpoint-component-calls']
  modelType: 'proxy-endpoint-component-call'
  'option-groups': Ember.computed 'controllers.proxy-endpoints.remote_endpoints.@each', ->
    remote_endpoint: @get('controllers.proxy-endpoints.remote_endpoints').filterBy 'isNew', false
  fields: Ember.computed 'isNew', ->
    baseFields = 'remote_endpoint:resources.remote-endpoint::select-model-name,endpoint_name_override'
    if @get 'isNew'
      baseFields
    else
      "#{baseFields},conditional:fields.call_conditional::javascript,conditional_positive"
  actions:
    beforeSave: ->
      model = @get 'model'
      if model.get 'isNew'
        calls = @get 'controllers.proxy-endpoint-component-calls.model'
        calls.pushObject model

`export default ProxyEndpointComponentCallFormController`
