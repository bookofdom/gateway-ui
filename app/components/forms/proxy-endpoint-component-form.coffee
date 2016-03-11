`import BaseFormComponent from 'gateway/components/forms/base-form'`

ProxyEndpointComponentFormComponent = BaseFormComponent.extend
  callsIndexModel: null
  'calls-option-groups': null
  'transformation-option-groups': null
  'option-groups': null

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    type = 'shared' if @get 'model.shared'
    "components/forms/proxy-endpoint-component/#{type}-form"

  fields: Ember.computed 'model.js', 'model.single', 'model.multi', 'model.shared', ->
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
    if @get 'model.shared'
      fields = [
        name: 'shared_component'
        type: 'select-model-name'
        label: 'resources.shared-component'
      ]
    fields

  createNewCallModel: ->
    model = @get 'model'
    newModel = @get('store').createRecord 'proxy-endpoint-component-call'
    newBefore = @get('store').createRecord 'proxy-endpoint-component-transformation'
    newAfter = @get('store').createRecord 'proxy-endpoint-component-transformation'
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
