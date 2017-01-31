`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

SharedComponentFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'shared-component'

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "components/forms/shared-component/#{type}-form"

  callsIndexModel: null
  'calls-option-groups': null
  'transformation-option-groups': null
  'option-groups': null

  defaultFields: Ember.computed 'model.js', 'model.single', 'model.multi', 'model.advanced', ->
    fields = [
      name: 'name'
      required: true
    ,
      name: 'description'
      type: 'textarea'
    ,
      name: 'conditional_positive'
      type: 'conditional-positive'
    ,
      name: 'conditional'
      type: 'javascript'
    ]
    if (@get 'model.js') or (@get 'model.advanced')
      fields.push
        name: 'body'
        label: 'fields.logic'
        type: 'javascript'
    fields

  createNewCallModel: ->
    model = @get 'model'
    newModel = @get('store').createRecord 'shared-component-call'
    newBefore = @get('store').createRecord 'shared-component-transformation'
    newAfter = @get('store').createRecord 'shared-component-transformation'
    newModel.get('before').pushObject newBefore
    newModel.get('after').pushObject newAfter
    model.get('calls').pushObject newModel

  actions:
    'new-shared-component-call': (record) -> @createNewCallModel()
    'delete-shared-component-call': (record) -> record.deleteRecord()

`export default SharedComponentFormComponent`
