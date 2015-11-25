`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

BsTextComponent = BsBaseComponent.extend
  attributeBindings: [
    't:data-t'
    'secondary:data-secondary'
  ]
  t: null
  secondary: null
  icon: null
  'icon-type': 'gateway-icon'
  'icon-after': false
  'show-text': true
  text: Ember.computed 't', ->
    text = @get 't'
    t(text).htmlSafe() if text
  'secondary-text': Ember.computed 'secondary', ->
    secondary = @get 'secondary'
    t(secondary).htmlSafe() if secondary
  hasIconBefore: Ember.computed 'icon', 'icon-after', ->
    @get('icon') and !@get('icon-after')
  hasIconAfter: Ember.computed 'icon', 'icon-after', ->
    @get('icon') and @get('icon-after')
  textSrOnly: Ember.computed 'show-text', -> !@get 'show-text'
  textSrOnlyClass: Ember.computed 'textSrOnly', ->
    "sr-only" if @get 'textSrOnly'

`export default BsTextComponent`
