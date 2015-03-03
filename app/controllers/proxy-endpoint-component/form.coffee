`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentFormController = FormController.extend
  formTemplateName: Ember.computed 'type', ->
    type = @get 'type'
    "proxy-endpoint-component/form-#{type}"
  createNewCallModel: ->
    model = @get 'model'
    newModel = @store?.createRecord 'proxy-endpoint-component-call'
    newBefore = @store?.createRecord 'proxy-endpoint-component-transformation'
    newAfter = @store?.createRecord 'proxy-endpoint-component-transformation'
    newModel.get('before').pushObject newBefore
    newModel.get('after').pushObject newAfter
    model.get('calls').pushObject newModel
  actions:
    'new-proxy-endpoint-component-call': (record) -> @createNewCallModel()
    'delete-proxy-endpoint-component-call': (record) -> record.deleteRecord()
    afterSave: ->
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'

`export default ProxyEndpointComponentFormController`
