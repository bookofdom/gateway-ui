`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApModelFieldComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-feld']
  model: null
  field: null # 'fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type'
  fieldName: Ember.computed 'field', -> @get('field')?.split(':')?[0]
  label: Ember.computed 'field', ->
    @get('field')?.split(':')[1]?.trim() or "fields.#{@get 'fieldName'}"
  help: Ember.computed 'field', -> @get('field')?.split(':')[2]?.trim()
  attribute: Ember.computed 'model', 'fieldName', ->
    attributes = []
    @get('model')?.eachAttribute (name, meta) -> attributes.push meta
    attributes.findBy 'name', @get('fieldName')
  type: Ember.computed 'field', ->
    attribute = @get 'attribute'
    @get('field')?.split(':')[3]?.trim() or attribute?.type or 'string'
  checkbox: Ember.computed 'type', -> @get('type') == 'checkbox'
  radio: Ember.computed 'type', -> @get('type') == 'radio'
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
