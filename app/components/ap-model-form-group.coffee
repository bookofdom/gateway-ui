`import Ember from 'ember'`
`import BsFormGroupComponent from 'gateway/components/bs-form-group'`
`import t from '../helpers/i18n'`

ApModelFormGroupComponent = BsFormGroupComponent.extend
  classNames: ['ap-model-form-group']
  classNameBindings: ['hasErrors:has-error']
  model: null

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
    get: ->
      fieldLabel = @get 'fieldLabel'
      if fieldLabel == false
        ''
      else
        @get('fieldLabel') or ("fields.#{@get 'name'}" if @get 'name')
    set: (key, value) ->
      @set 'fieldLabel', value if value?
      @get 'label'

  'label-for': Ember.computed 'model', 'name', ->
    modelName = @get 'model.constructor.modelName'
    id = @get('model.id') or @get('model.clientId')
    name = @get 'name'
    if id then "#{modelName}-#{id}-#{name}" else "#{modelName}-#{name}"

  help: Ember.computed 'fieldHelp', 'hasErrors',
    get: ->
      helpKey = "fields.help.#{@get 'name'}"
      help = @get('fieldHelp') or (t helpKey if @get 'name')
      # If help was looked-up via a translation key and no translation was found,
      # do not pass string.
      help = null if help.toLowerCase() == helpKey
      help = @get('error-messages').join ' ' if @get 'hasErrors'
      help
    set: (key, value) ->
      @set 'fieldHelp', value if value?
      @get 'help'

  required: Ember.computed 'fieldRequired',
    get: -> @get 'fieldRequired'
    set: (key, value) ->
      @set 'fieldRequired', value if value?
      value

  attribute: Ember.computed 'model', 'name', ->
    attributes = []
    @get('model')?.eachAttribute (name, meta) -> attributes.push meta
    attributes.findBy 'name', @get('name')
  
  type: Ember.computed 'fieldType',
    get: ->
      attribute = @get 'attribute'
      type = @get('fieldType') or attribute?.type or 'string'
      type = 'boolean' if type == 'checkbox' or type == 'radio'
      type
    set: (key, value) ->
      @set 'fieldType', value if value?
      @get 'type'

  checkbox: Ember.computed 'type', ->
    (@get('type') == 'checkbox') or (@get('type') == 'boolean')
  radio: Ember.computed 'type', -> @get('type') == 'radio'
  errorsForField: Ember.computed 'model.errors.[]', 'name', ->
    name = @get 'name'
    @get('model.errors')?.errorsFor(name) or []
  'error-messages': Ember.computed 'errorsForField.[]', ->
    "#{error.message.capitalize()}" for error in @get('errorsForField')
  hasErrors: Ember.computed 'error-messages', -> !!@get('error-messages.length')

`export default ApModelFormGroupComponent`
