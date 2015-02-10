`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentFormController = FormController.extend
  formTemplateName: Ember.computed 'type', ->
    type = @get 'type'
    "proxy-endpoint-component/form-#{type}"
  actions:
    submit: ->
      proxyEndpoint = @get 'model.proxy_endpoint'
      proxyEndpoint.save().then (=>
        # "rollback" to now-saved embedded records
        @send 'rollback'
      ), (=>)
      false
    cancel: ->
      @send 'rollback'
    rollback: ->
      @get('model.call')?.rollback()
      @get('model.calls')?.forEach (record) -> record.rollback()
      @get('model.before')?.forEach (record) -> record.rollback()
      @get('model.after')?.forEach (record) -> record.rollback()
      @get('model').rollback()

`export default ProxyEndpointComponentFormController`
