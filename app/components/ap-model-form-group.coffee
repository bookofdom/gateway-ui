`import Ember from 'ember'`
`import BsFormGroupComponent from 'gateway/components/bs-form-group'`

ApModelFormGroupComponent = BsFormGroupComponent.extend
  classNames: ['ap-model-form-group']
  classNameBindings: ['hasErrors:has-error']
  model: null
  field: null # 'fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type'
  fieldName: Ember.computed 'field', -> @get('field')?.split(':')[0]
  label: Ember.computed 'field', ->
    @get('field')?.split(':')[1]?.trim() or "fields.#{@get 'fieldName'}"
  'label-for': Ember.computed 'fieldName', -> @get 'fieldName'
  help: Ember.computed 'field', 'hasErrors', ->
    if @get 'hasErrors'
      @get('error-messages').join ' '
    else
      @get('field')?.split(':')[2]?.trim()
  attribute: Ember.computed 'model', 'fieldName', ->
    attributes = []
    @get('model')?.eachAttribute (name, meta) -> attributes.push meta
    attributes.findBy 'name', @get('fieldName')
  type: Ember.computed 'field', ->
    attribute = @get 'attribute'
    type = @get('field')?.split(':')[3]?.trim() or attribute?.type or 'string'
    type = 'boolean' if type == 'checkbox'
    type
  checkbox: Ember.computed 'type', ->
    (@get('type') == 'checkbox') or (@get('type') == 'boolean')
  radio: Ember.computed 'type', -> @get('type') == 'radio'
  errorsForField: Ember.computed 'model.errors.@each', 'fieldName', ->
    fieldName = @get 'fieldName'
    @get('model.errors')?.errorsFor(fieldName) or []
  'error-messages': Ember.computed 'errorsForField.@each', ->
    "#{error.message.capitalize()}" for error in @get('errorsForField')
  hasErrors: Ember.computed 'error-messages', -> @get('error-messages')

`export default ApModelFormGroupComponent`
