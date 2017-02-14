`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`

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
  hasIconBefore: Ember.computed 'icon', 'icon-after', ->
    @get('icon') and !@get('icon-after')
  hasIconAfter: Ember.computed 'icon', 'icon-after', ->
    @get('icon') and @get('icon-after')
  textSrOnly: Ember.computed 'show-text', -> !@get 'show-text'
  textSrOnlyClass: Ember.computed 'textSrOnly', ->
    "sr-only" if @get 'textSrOnly'

`export default BsTextComponent`
