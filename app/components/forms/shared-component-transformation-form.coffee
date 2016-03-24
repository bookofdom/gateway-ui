`import BaseForm from './base-form'`

SharedComponentTransformationFormComponent = BaseForm.extend
  'option-groups': null # passed in by controllers

  modelType: 'shared-component-transformation'

  before: false
  after: false

  fields: Ember.computed 'before', 'after', ->
    typeLabel = 'fields.type'
    bodyLabel = 'fields.logic'
    if @get 'before'
      typeLabel = 'fields.before-type'
      bodyLabel = 'fields.before'
    if @get 'after'
      typeLabel = 'fields.after-type'
      bodyLabel = 'fields.after'
    [
      name: 'body'
      label: bodyLabel
      type: 'javascript'
    ]

`export default SharedComponentTransformationFormComponent`
