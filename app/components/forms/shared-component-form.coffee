`import BaseFormComponent from './base-form'`

SharedComponentFormComponent = BaseFormComponent.extend
  modelType: 'shared-component'

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "components/forms/shared-component/#{type}-form"

  'option-groups': null
  
  defaultFields: Ember.computed 'model.js', 'model.single', 'model.multi', ->
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

`export default SharedComponentFormComponent`
