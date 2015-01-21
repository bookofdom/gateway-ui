`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`
`import t from 'gateway/helpers/i18n'`

BsFormGroupComponent = BsTextComponent.extend
  classNames: ['form-group']
  classNameBindings: ['errorClass']
  label: null
  help: null
  horizontal: false
  checkbox: false
  radio: false
  error: false
  'show-label': true
  'label-for': null
  t: Ember.computed 'label', -> @get 'label'
  secondary: Ember.computed 'help', -> @get 'help'
  errorClass: Ember.computed 'error', -> 'has-error' if @get 'error'
  offset: Ember.computed 'is-boolean', -> @get 'is-boolean'
  'control-label-classes': Ember.computed 'horizontal', 'show-label', ->
    labelClasses = ['text-capitalize']
    labelClasses.push('col-sm-2') if @get 'horizontal'
    labelClasses.push('sr-only') if !@get 'show-label'
    labelClasses.join ' '
  'control-wrapper-classes': Ember.computed 'horizontal', ->
    controlWrapperClasses = []
    controlWrapperClasses.push('col-sm-10') if @get 'horizontal'
    controlWrapperClasses.push('col-sm-offset-2') if @get 'offset'
    controlWrapperClasses.join ' '
  'boolean-type-class': Ember.computed 'checkbox', 'radio', ->
    booleanTypeClass = null
    booleanTypeClass = 'checkbox' if @get 'checkbox'
    booleanTypeClass = 'radio' if @get 'radio'
    booleanTypeClass
  'is-boolean': Ember.computed 'checkbox', 'radio', ->
    @get('checkbox') or @get('radio')

`export default BsFormGroupComponent`
