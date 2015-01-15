`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

BsTextComponent = BsBaseComponent.extend
  t: null
  secondary: null
  icon: null
  iconAfter: false
  text: Ember.computed 't', ->
    text = @get 't'
    t text if text
  'secondary-text': Ember.computed 'secondary', ->
    secondary = @get 'secondary'
    t secondary if secondary
  hasIconBefore: Ember.computed 'icon', 'iconAfter', ->
    @get('icon') and !@get('iconAfter')
  hasIconAfter: Ember.computed 'icon', 'iconAfter', ->
    @get('icon') and @get('iconAfter')

`export default BsTextComponent`
