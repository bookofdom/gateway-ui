`import BaseFormComponent from './base-form'`

SharedComponentFormComponent = BaseFormComponent.extend
  modelType: 'shared-component'

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "components/forms/shared-component/#{type}-form"

  'option-groups': null

  newFields: [
    name: 'type'
    type: 'select'
  ,
    name: 'name'
  ,
    name: 'description'
    type: 'textarea'
  ]

  editFields: Ember.computed 'model.js', ->
    fields = [
      name: 'name'
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
    if @get 'model.js'
      fields.push
        name: 'body'
        label: 'fields.logic'
        type: 'javascript'
    fields

`export default SharedComponentFormComponent`
