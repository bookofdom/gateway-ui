`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponentFormController = FormController.extend
  'api': Ember.inject.controller()

  callsIndexModel: Ember.computed.alias 'model.calls'
  'calls-option-groups': Ember.computed 'api.libraries', 'api.remote_endpoints.@each.isNew', ->
    conditional: @get 'api.libraries'
    remote_endpoint: @get('api.remote_endpoints').filterBy 'isNew', false

  'transformation-option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'
    type: [
      name: t('languages.javascript').capitalize()
      value: 'js'
    ]

  'option-groups': Ember.computed 'api.libraries', ->
    conditional: @get 'api.libraries'
    body: @get 'api.libraries'
  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "proxy-endpoint-component/form-#{type}"
  fields: Ember.computed 'model.js', 'model.single', 'model.multi', ->
    fields = [
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      type: 'javascript'
    ]
    if @get 'model.js'
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
    afterDelete: ->
      @send 'deleted'

`export default ProxyEndpointComponentFormController`
