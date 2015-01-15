`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsDropdownComponent = BsTextComponent.extend
  classNames: ['dropdown']
  style: 'default'
  buttonStyleClass: Ember.computed 'style', -> "btn-#{@get 'style'}"
  alignmentClass: Ember.computed '{left,right}', ->
    'dropdown-menu-left' if @get 'left'
    'dropdown-menu-right' if @get 'right'

`export default BsDropdownComponent`
