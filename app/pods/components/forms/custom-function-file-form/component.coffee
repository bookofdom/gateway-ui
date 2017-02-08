`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

CustomFunctionFileFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'custom-function-file'
  savedAction: null

  newFields: [
    name: 'name'
    required: true
  ]
  editFields: [
    name: 'name'
    required: true
  ,
    name: 'body'
    type: 'file-editor'
  ]
  fields: Ember.computed 'model.isNew', ->
    if @get('model.isNew') then @get('newFields') else @get('editFields')

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      customFunctionFiles = @get 'indexModel'
      customFunctionFiles.pushObject model
    @_super arguments...

`export default CustomFunctionFileFormComponent`
