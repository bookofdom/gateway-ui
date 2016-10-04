`import Ember from 'ember'`
`import BsFormGroupComponent from 'gateway/pods/components/bs-form-group/component'`
`import t from 'gateway/helpers/i18n'`

ApModelFormGroupComponent = BsFormGroupComponent.extend
  classNames: ['ap-model-form-group']
  classNameBindings: ['hasErrors:has-error']
  model: null

  fieldName: null
  fieldLabel: null
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
    modelName = @get('model').constructor.modelName
    id = @get('model.id') or @get('model.clientId')
    name = @get 'name'
    if id then "#{modelName}-#{id}-#{name}" else "#{modelName}-#{name}"

  errorHelp: Ember.computed 'hasErrors', ->
    @get('error-messages').join ' ' if @get 'hasErrors'

  secondary: Ember.computed 'help', 'errorHelp', ->
    helpKey = "fields.help.#{@get 'name'}"
    help = @get('help') or (t helpKey if @get 'name')
    # If help was looked-up via a translation key and no translation was found,
    # do not pass string.
    help = null if help.toLowerCase() == helpKey
    errorHelp = @get 'errorHelp'
    help = errorHelp if errorHelp
    help

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

  'error-messages': Ember.computed 'model.errors.[]', 'model.errors.length', 'name', ->
    name = @get 'name'
    errorsForField = @get('model.errors')?.errorsFor(name) or []
    (error.message or error.message.capitalize?()) for error in errorsForField

  hasErrors: Ember.computed 'error-messages.[]', 'error-messages.length', ->
    !!@get('error-messages.length')

`export default ApModelFormGroupComponent`
