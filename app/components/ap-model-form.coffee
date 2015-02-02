`import Ember from 'ember'`
`import BsFormComponent from 'gateway/components/bs-form'`
`import t from 'gateway/helpers/i18n'`

ApModelFormComponent = BsFormComponent.extend
  classNames: ['ap-model-form']
  action: 'submit'
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type' or 'fieldName,fieldName'
  horizontal: true
  'auto-save': true
  'option-groups': null
  fieldsList: Ember.computed 'fields', ->
    for field in @get('fields')?.split ','
      fieldName = field.split(':')[0]
      options: @get('option-groups')?[fieldName]
      prompt: t('prompts.generic').capitalize()
      field: field
  dirty: Ember.computed 'model.isDirty', -> @get 'model.isDirty'
  'show-save': Ember.computed 'dirty', -> @get 'dirty'
  'show-cancel': Ember.computed 'dirty', -> @get 'dirty'
  submit: ->
    autoSave = @get 'auto-save'
    @sendAction() if @get('dirty') and !autoSave
    @get('model').save().then((=>), (=>)) if autoSave
    false
  actions:
    cancel: -> @get('model').rollback()

`export default ApModelFormComponent`
