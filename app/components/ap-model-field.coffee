`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

ApModelFieldComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-field']
  model: null
  'show-placeholder': false
  fieldName: null
  fieldLabel: null
  fieldHelp: null
  fieldType: null
  fieldRequired: null
  name: Ember.computed 'fieldName', (key, value, previousValue) ->
    @set 'fieldName', value if value? and (value != previousValue)
    @get 'fieldName'
  label: Ember.computed 'fieldLabel', (key, value, previousValue) ->
    @set 'fieldLabel', value if value? and (value != previousValue)
    @get('fieldLabel') or
      ("fields.#{@get 'name'}" if @get 'name')
  help: Ember.computed 'fieldHelp', (key, value, previousValue) ->
    @set 'fieldHelp', value if value? and (value != previousValue)
    @get 'fieldHelp'
  type: Ember.computed 'fieldType', (key, value, previousValue) ->
    @set 'fieldType', value if value? and (value != previousValue)
    attribute = @get 'attribute'
    type = @get('fieldType') or attribute?.type or 'string'
    type = 'boolean' if type == 'checkbox' or type == 'radio'
    type
  required: Ember.computed 'fieldRequired', (key, value, previousValue) ->
    @set 'fieldRequired', value if value? and (value != previousValue)
    @get 'fieldRequired'
  placeholder: Ember.computed 'show-placeholder', 'label', ->
    t(@get 'label').capitalize() if @get 'show-placeholder'
  prompt: Ember.computed 'label', ->
    t('prompts.choose-x', x: @get 'label').capitalize()
  attribute: Ember.computed 'model', 'name', ->
    attributes = []
    @get('model')?.eachAttribute (name, meta) -> attributes.push meta
    attributes.findBy 'name', @get('name')
  checkbox: Ember.computed 'type', ->
    (@get('type') == 'checkbox') or (@get('type') == 'boolean')
  radio: Ember.computed 'type', -> @get('type') == 'radio'
  idName: Ember.computed 'model', 'name', ->
    typeKey = @get 'model.constructor.typeKey'
    id = @get('model.id') or @get('model.clientId')
    name = @get 'name'
    if id then "#{typeKey}-#{id}-#{name}" else "#{typeKey}-#{name}"
  fieldTemplateName: Ember.computed 'type', ->
    "components/ap-model-field/-#{@get 'type'}"
  setupValueAttribute: Ember.on 'init', ->
    computed = Ember.computed 'model', 'name', "model.#{@get 'name'}", (key, value, previousValue) ->
      name = @get 'name'
      currentValue = @get "model.#{name}"
      if !Ember.isNone(value) and (value != currentValue)
        @set "model.#{name}", value
      @get "model.#{name}"
    Ember.defineProperty @, 'value', computed

`export default ApModelFieldComponent`
