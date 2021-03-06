`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import CustomFunction from 'gateway-ui/pods/custom-function/model'`

CustomFunctionFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'custom-function'

  savedAction: null

  'option-groups': Ember.computed ->
    language: CustomFunction.languages

  newFields: [
    name: 'name'
    required: true
  ,
    name: 'language'
    required: true
    type: 'select-name-key'
  ]
  editFields: [
    name: 'name'
    required: true
  ,
    name: 'active'
  ,
    name: 'memory'
    help: 'fields.help.memory'
  ,
    name: 'cpu_shares'
  ,
    name: 'timeout'
  ,
    name: 'description'
    type: 'textarea'
  ]
  fields: Ember.computed 'model.isNew', ->
    if @get('model.isNew') then @get('newFields') else @get('editFields')

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      customFunctions = @get 'indexModel'
      customFunctions.pushObject model
    @_super arguments...

`export default CustomFunctionFormComponent`
