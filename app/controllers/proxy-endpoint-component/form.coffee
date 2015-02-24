`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentFormController = FormController.extend
  formTemplateName: Ember.computed 'type', ->
    type = @get 'type'
    "proxy-endpoint-component/form-#{type}"
  actions:
    afterSave: ->
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'

`export default ProxyEndpointComponentFormController`
