`import Ember from 'ember'`
`import BsFormGroupComponent from 'gateway/components/bs-form-group'`

ApModelFormGroupComponent = BsFormGroupComponent.extend
  classNames: ['ap-model-form-group']
  classNameBindings: ['hasErrors:has-error']
  model: null
  field: null # 'fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type'
  fieldName: Ember.computed 'field', -> @get('field').split(':')[0]
  label: Ember.computed 'field', ->
    @get('field').split(':')[1]?.trim() or "fields.#{@get 'fieldName'}"
  help: Ember.computed 'field', 'hasErrors', ->
    if @get 'hasErrors'
      @get('error-messages').join ' '
    else
      @get('field').split(':')[2]?.trim()
  type: Ember.computed 'field', -> @get('field').split(':')[3]?.trim()
  checkbox: Ember.computed 'type', -> @get('type') == 'checkbox'
  radio: Ember.computed 'type', -> @get('type') == 'radio'
  errorsForField: Ember.computed 'model.errors.@each', 'fieldName', ->
    fieldName = @get 'fieldName'
    @get('model.errors')?.errorsFor(fieldName) or []
  'error-messages': Ember.computed 'errorsForField.@each', ->
    "#{error.message.capitalize()}" for error in @get('errorsForField')
  hasErrors: Ember.computed 'error-messages', -> @get('error-messages')

`export default ApModelFormGroupComponent`
