`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

BsTypographyComponent = BsBaseComponent.extend
  t: null
  secondary: null
  text: Ember.computed 't', ->
    text = @get 't'
    t text if text
  'secondary-text': Ember.computed 'secondary', ->
    secondary = @get 'secondary'
    t secondary if secondary

`export default BsTypographyComponent`
