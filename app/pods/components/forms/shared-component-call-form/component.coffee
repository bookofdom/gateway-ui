`import BaseForm from 'gateway/pods/components/forms/base-form/component'`

SharedComponentCallFormComponent = BaseForm.extend
  indexModel: null
  'option-groups': null # passed in by controllers
  'transformation-option-groups': null

  modelType: 'shared-component-call'

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
    if model.get 'isNew'
      if model.get('before.length') == 0
        newBefore = store.createRecord 'shared-component-transformation'
        model.get('before').pushObject newBefore
      if model.get('after.length') == 0
        newAfter = store.createRecord 'shared-component-transformation'
        model.get('after').pushObject newAfter
      calls = @get 'indexModel'
      calls.pushObject model
    @_super.apply @, arguments

`export default SharedComponentCallFormComponent`
