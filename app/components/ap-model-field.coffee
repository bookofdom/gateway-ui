`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

ApModelFieldComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-field']
  model: null
  field: null # 'fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type'
  options: null
  'show-placeholder': false
  fieldName: Ember.computed 'field', -> @get('field')?.split(':')?[0]
  label: Ember.computed 'field', ->
    @get('field')?.split(':')[1]?.trim() or "fields.#{@get 'fieldName'}"
  placeholder: Ember.computed 'show-placeholder', 'label', ->
    t(@get('label')).capitalize() if @get 'show-placeholder'
  prompt: Ember.computed 'label', ->
    t('prompts.choose-x', x: @get 'label').capitalize()
  help: Ember.computed 'field', -> @get('field')?.split(':')[2]?.trim()
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
  idName: Ember.computed 'model', 'fieldName', ->
    typeKey = @get 'model.constructor.typeKey'
    id = @get('model.id') or @get('model.clientId')
    fieldName = @get 'fieldName'
    if id then "#{typeKey}-#{id}-#{fieldName}" else "#{typeKey}-#{fieldName}"
  fieldTemplateName: Ember.computed 'type', ->
    "components/ap-model-field/-#{@get 'type'}"
  setupValueAttribute: Ember.on 'init', ->
    computed = Ember.computed 'model', 'fieldName', "model.#{@get 'fieldName'}", (key, value, previousValue) ->
      fieldName = @get 'fieldName'
      currentValue = @get "model.#{fieldName}"
      if !Ember.isNone(value) and (value != currentValue)
        @set "model.#{fieldName}", value
      @get "model.#{fieldName}"
    Ember.defineProperty @, 'value', computed

`export default ApModelFieldComponent`
