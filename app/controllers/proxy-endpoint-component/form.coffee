`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentFormController = FormController.extend
  formTemplateName: Ember.computed 'type', ->
    type = @get 'type'
    "proxy-endpoint-component/form-#{type}"
  actions:
    submit: ->
      model = @get 'model'
      proxyEndpoint = @get 'model.proxy_endpoint'
      proxyEndpoint.save().then (=>
        model.rollback() # "rollback" to now-saved embedded component
      ), (=>)
      false

`export default ProxyEndpointComponentFormController`
