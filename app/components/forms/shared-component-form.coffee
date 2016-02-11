`import BaseFormComponent from './base-form'`

SharedComponentFormComponent = BaseFormComponent.extend
  modelType: 'shared-component'

  formTemplateName: Ember.computed 'model.type', ->
    type = @get 'model.type'
    "components/forms/shared-component/#{type}-form"

`export default SharedComponentFormComponent`
