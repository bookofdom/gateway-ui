`import Ember from 'ember'`
`import BsTextComponent from 'gateway-ui/pods/components/bs-text/component'`
`import t from 'gateway-ui/helpers/i18n'`

BsFormGroupComponent = BsTextComponent.extend
  classNames: ['form-group']
  classNameBindings: ['error:has-error']
  label: null
  help: null
  inline: false
  horizontal: false
  checkbox: false
  radio: false
  error: false
  required: false
  'show-label': true
  'label-for': null
  offset: null
  t: Ember.computed 'label', -> @get 'label'
  secondary: Ember.computed 'help', -> @get 'help'
  'control-label-classes': Ember.computed 'horizontal', 'show-label', ->
    labelClasses = []
    labelClasses.push('control-label') if !@get 'inline'
    labelClasses.push('col-sm-2') if @get 'horizontal'
    labelClasses.push('sr-only') if !@get 'show-label'
    labelClasses.join ' '
  'control-wrapper-classes': Ember.computed 'horizontal', ->
    controlWrapperClasses = []
    controlWrapperClasses.push('col-sm-10') if @get 'horizontal'
    controlWrapperClasses.push('col-sm-offset-2') if @get 'isOffset'
    controlWrapperClasses.join ' '
  'boolean-type-class': Ember.computed 'checkbox', 'radio', ->
    booleanTypeClass = null
    booleanTypeClass = 'checkbox' if @get 'checkbox'
    booleanTypeClass = 'radio' if @get 'radio'
    booleanTypeClass
  'is-boolean': Ember.computed 'checkbox', 'radio', ->
    @get('checkbox') or @get('radio')
  isOffset: Ember.computed 'horizontal', 'offset', ->
    @get('horizontal') and @get('offset')

`export default BsFormGroupComponent`
