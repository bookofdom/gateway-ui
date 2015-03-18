`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

BsTextComponent = BsBaseComponent.extend
  t: null
  secondary: null
  icon: null
  'icon-type': 'retina'
  iconAfter: false
  'show-text': true
  text: Ember.computed 't', ->
    text = @get 't'
    t(text).htmlSafe() if text
  'secondary-text': Ember.computed 'secondary', ->
    secondary = @get 'secondary'
    t(secondary).htmlSafe() if secondary
  hasIconBefore: Ember.computed 'icon', 'iconAfter', ->
    @get('icon') and !@get('iconAfter')
  hasIconAfter: Ember.computed 'icon', 'iconAfter', ->
    @get('icon') and @get('iconAfter')
  textSrOnly: Ember.computed 'show-text', -> !@get 'show-text'
  textSrOnlyClass: Ember.computed 'textSrOnly', ->
    "sr-only" if @get 'textSrOnly'

`export default BsTextComponent`
