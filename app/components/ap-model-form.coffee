`import Ember from 'ember'`
`import BsFormComponent from 'gateway/components/bs-form'`

ApModelFormComponent = BsFormComponent.extend
  classNames: ['ap-model-form']
  action: 'submit'
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type' or 'fieldName,fieldName'
  horizontal: true
  'auto-save': true
  fieldsList: Ember.computed 'fields', -> @get('fields')?.split ','
  dirty: Ember.computed 'model.isDirty', -> @get 'model.isDirty'
  submit: ->
    autoSave = @get 'auto-save'
    @sendAction() if @get('dirty') and !autoSave
    @get('model').save().then((=>), (=>)) if autoSave
    false
  actions:
    cancel: -> @get('model').rollback()

`export default ApModelFormComponent`
