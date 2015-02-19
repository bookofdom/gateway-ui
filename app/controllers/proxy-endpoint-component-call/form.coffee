`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentCallFormController = FormController.extend
  needs: ['proxy-endpoints']
  'option-groups': Ember.computed 'controllers.proxy-endpoints.remote_endpoints', ->
    remote_endpoint: @get('controllers.proxy-endpoints.remote_endpoints').filterBy 'isNew', false

`export default ProxyEndpointComponentCallFormController`
