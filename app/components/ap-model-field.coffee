`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

ApModelFieldComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-field']
  model: null
  'show-placeholder': false
  'option-groups': null
  fieldName: null
  fieldLabel: null
  fieldHelp: null
  fieldType: null
  fieldRequired: null
  name: Ember.computed 'fieldName',
    get: -> @get 'fieldName'
    set: (key, value) ->
      @set 'fieldName', value if value?
      value
  label: Ember.computed 'fieldLabel',
    get: -> @get('fieldLabel') or ("fields.#{@get 'name'}" if @get 'name')
    set: (key, value) ->
      @set 'fieldLabel', value if value?
      @get 'label'
  help: Ember.computed 'fieldHelp',
    get: -> @get 'fieldHelp'
    set: (key, value) ->
      @set 'fieldHelp', value if value?
      value
  type: Ember.computed 'fieldType',
    get: ->
      attribute = @get 'attribute'
      type = @get('fieldType') or attribute?.type or 'string'
      type = 'boolean' if type == 'checkbox' or type == 'radio'
      type
    set: (key, value) ->
      @set 'fieldType', value if value?
      @get 'type'
  required: Ember.computed 'fieldRequired',
    get: -> @get 'fieldRequired'
    set: (key, value) ->
      @set 'fieldRequired', value if value?
      value
  placeholder: Ember.computed 'show-placeholder', 'label', 'required', ->
    if @get 'show-placeholder'
      label = t(@get 'label').capitalize()
      label = "#{label}*" if @get 'required'
      label
  prompt: Ember.computed 'label', ->
    t('prompts.choose-x', x: @get 'label').capitalize()
  options: Ember.computed 'name', 'option-groups', ->
    @get('option-groups')?[@get('name')]
  attribute: Ember.computed 'model', 'name', ->
    attributes = []
    @get('model')?.eachAttribute (name, meta) -> attributes.push meta
    attributes.findBy 'name', @get('name')
  checkbox: Ember.computed 'type', ->
    (@get('type') == 'checkbox') or (@get('type') == 'boolean')
  radio: Ember.computed 'type', -> @get('type') == 'radio'
  idName: Ember.computed 'model', 'name', ->
    modelName = @get('model').constructor.modelName
    id = @get('model.id') or @get('model.clientId')
    name = @get 'name'
    if id then "#{modelName}-#{id}-#{name}" else "#{modelName}-#{name}"
  fieldTemplateName: Ember.computed 'type', ->
    "components/ap-model-field/-#{@get 'type'}"
  setupValueAttribute: Ember.on 'init', ->
    name = @get 'name'
    propName = "model.#{@get 'name'}"
    computed = Ember.computed propName,
      get: -> @get propName
      set: (key, value) ->
        currentValue = @get propName
        @set propName, value if value? and (value != currentValue)
        value
    Ember.defineProperty @, 'value', computed

`export default ApModelFieldComponent`
