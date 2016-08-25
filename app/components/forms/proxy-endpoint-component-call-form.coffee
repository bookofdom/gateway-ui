`import BaseForm from 'gateway/components/forms/base-form'`

ProxyEndpointComponentCallFormComponent = BaseForm.extend
  indexModel: null
  prefix: 'proxy-endpoint'
  'option-groups': null # passed in by controllers
  'transformation-option-groups': null

  modelType: Ember.computed 'prefix', ->
    prefix = @get 'prefix'
    "#{prefix}-component-call"

  fields: Ember.computed 'model.isNew', ->
    newFields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ]
    editFields = [
      name: 'remote_endpoint'
      label: 'resources.remote-endpoint'
      type: 'select-model-name'
      required: true
    ,
      name: 'endpoint_name_override'
    ,
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      label: 'fields.call-conditional'
      type: 'javascript'
    ]
    if @get 'model.isNew' then newFields else editFields

  submit: ->
    model = @get 'model'
    store = @get 'store'
    prefix = @get 'prefix'
    if model.get 'isNew'
      if model.get('before.length') == 0
        newBefore = store.createRecord "#{prefix}-component-transformation"
        model.get('before').pushObject newBefore
      if model.get('after.length') == 0
        newAfter = store.createRecord "#{prefix}-component-transformation"
        model.get('after').pushObject newAfter
      calls = @get 'indexModel'
      calls.pushObject model
    @_super arguments...

`export default ProxyEndpointComponentCallFormComponent`
