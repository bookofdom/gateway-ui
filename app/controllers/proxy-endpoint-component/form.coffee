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
    cancel: ->
      @get('model.call')?.rollback()
      @get('model.before')?.forEach (record) -> record.rollback()
      @get('model.after')?.forEach (record) -> record.rollback()
      @get('model').rollback()

`export default ProxyEndpointComponentFormController`
