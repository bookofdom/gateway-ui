`import BaseFormComponent from './base-form'`

ProxyEndpointComponentFormComponent = BaseFormComponent.extend
  callsIndexModel: null
  'calls-option-groups': null
  'transformation-option-groups': null
  'option-groups': null

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "components/forms/proxy-endpoint-component/#{type}-form"

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
    saved: ->
      @notifySaveSuccess()
      # resend this action (using a different name)
      # so that the router can handle it if necessary
      @send 'saved'

`export default ProxyEndpointComponentFormComponent`
