`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsPanelComponent = BsTextComponent.extend
  classNames: ['panel']
  classNameBindings: ['styleClass']
  style: 'default'
  styleClass: Ember.computed 'style', ->
    "panel-#{@get 'style'}"

`export default BsPanelComponent`
