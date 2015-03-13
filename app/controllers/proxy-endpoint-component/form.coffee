`import FormController from 'gateway/controllers/form'`

ProxyEndpointComponentFormController = FormController.extend
  formTemplateName: Ember.computed 'type', ->
    type = @get 'type'
    "proxy-endpoint-component/form-#{type}"
  fields: Ember.computed 'js', 'single', 'multi', ->
    fields = [
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      type: 'javascript'
    ]
    if @get 'js'
      fields.push
        name: 'body'
        label: 'fields.logic'
        type: 'javascript'
    fields
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
      @notifySaveSuccess()
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'

`export default ProxyEndpointComponentFormController`
