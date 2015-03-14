`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsPanelComponent = BsTextComponent.extend
  classNames: ['panel']
  classNameBindings: ['styleClass']
  style: 'default'
  collapse: false
  closed: false
  styleClass: Ember.computed 'style', ->
    "panel-#{@get 'style'}"
  'show-heading': Ember.computed 't', 'secondary', 'icon', ->
    @get('t') or @get('secondary') or @get('icon')
  'panel-collapse-id': Ember.computed 'collapse', ->
    randomNumber = Math.round(Math.random() * 1000)
    "panel-collapse-#{randomNumber}" if @get 'collapse'
  'collapse-href': Ember.computed 'panel-collapse-id', ->
    "##{@get 'panel-collapse-id'}" if @get 'panel-collapse-id'

`export default BsPanelComponent`
