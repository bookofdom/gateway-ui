`import Ember from 'ember'`
`import BsTypographyComponent from 'gateway/components/bs-typography'`

BsDropdownComponent = BsTypographyComponent.extend
  classNames: ['dropdown']
  style: 'default'
  left: null
  right: null
  buttonStyleClass: Ember.computed 'style', -> "btn-#{@get 'style'}"
  alignmentClass: Ember.computed '{left,right}', ->
    'dropdown-menu-left' if @get 'left'
    'dropdown-menu-right' if @get 'right'

`export default BsDropdownComponent`
