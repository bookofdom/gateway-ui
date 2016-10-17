`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/pods/components/bs-base/component'`
`import t from 'gateway/helpers/i18n'`

ApModelFieldComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-field']
  model: null
  'show-placeholder': false
  'option-groups': null
  fieldName: null
  fieldLabel: null
  fieldType: null
  fieldPrompt: null
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
  type: Ember.computed 'fieldType',
    get: ->
      attribute = @get 'attribute'
      type = @get('fieldType') or attribute?.type or 'string'
      type = 'boolean' if type == 'checkbox' or type == 'radio'
      type
    set: (key, value) ->
      @set 'fieldType', value if value?
      @get 'type'
  isSelect: Ember.computed 'type', ->
    !!@get('type').match /select/
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
  prompt: Ember.computed 'label', 'fieldPrompt',
    get: ->
      prompt = @get 'fieldPrompt'
      prompt = t('prompts.choose-x', x: @get 'label').capitalize() if !prompt?
      prompt
    set: (key, value) ->
      currentValue = @get 'fieldPrompt'
      @set 'fieldPrompt', value if value? and (value != currentValue)
      @get 'prompt'
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
    computed = Ember.computed propName, 'prompt', 'options.[]', 'isSelect',
      get: ->
        value = @get propName
        prompt = @get 'prompt'
        firstOption = @get 'options.firstObject'
        isSelect = @get 'isSelect'
        # Selects with no value set AND no prompt should have the first
        # option automatically selected as the value.
        if isSelect and !prompt and firstOption and !value
          @set 'value', firstOption
        value
      set: (key, value) ->
        currentValue = @get propName
        @set propName, value if value? and (value != currentValue)
        value
    Ember.defineProperty @, 'value', computed

`export default ApModelFieldComponent`