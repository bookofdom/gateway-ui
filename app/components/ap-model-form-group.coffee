`import Ember from 'ember'`
`import BsFormGroupComponent from 'gateway/components/bs-form-group'`

ApModelFormGroupComponent = BsFormGroupComponent.extend
  classNames: ['ap-model-form-group']
  classNameBindings: ['hasErrors:has-error']
  model: null
  
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
  
  'label-for': Ember.computed 'model', 'name', ->
    typeKey = @get 'model.constructor.typeKey'
    id = @get('model.id') or @get('model.clientId')
    name = @get 'name'
    if id then "#{typeKey}-#{id}-#{name}" else "#{typeKey}-#{name}"
  
  help: Ember.computed 'fieldHelp', 'hasErrors', (key, value, previousValue) ->
    @set 'fieldHelp', value if value? and (value != previousValue)
    help = @get 'fieldHelp'
    help = @get('error-messages').join ' ' if @get 'hasErrors'
    help
  required: Ember.computed 'fieldRequired', (key, value, previousValue) ->
    @set 'fieldRequired', value if value? and (value != previousValue)
    @get 'fieldRequired'
  
  attribute: Ember.computed 'model', 'name', ->
    attributes = []
    @get('model')?.eachAttribute (name, meta) -> attributes.push meta
    attributes.findBy 'name', @get('name')
  type: Ember.computed 'fieldType', (key, value, previousValue) ->
    @set 'fieldType', value if value? and (value != previousValue)
    attribute = @get 'attribute'
    type = @get('fieldType') or attribute?.type or 'string'
    type = 'boolean' if type == 'checkbox' or type == 'radio'
    type
  checkbox: Ember.computed 'type', ->
    (@get('type') == 'checkbox') or (@get('type') == 'boolean')
  radio: Ember.computed 'type', -> @get('type') == 'radio'
  errorsForField: Ember.computed 'model.errors.@each', 'name', ->
    name = @get 'name'
    @get('model.errors')?.errorsFor(name) or []
  'error-messages': Ember.computed 'errorsForField.@each', ->
    "#{error.message.capitalize()}" for error in @get('errorsForField')
  hasErrors: Ember.computed 'error-messages', -> @get('error-messages')

`export default ApModelFormGroupComponent`
