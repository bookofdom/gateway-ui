`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsButtonComponent = BsTextComponent.extend
  tagName: 'a'
  classNames: ['btn']
  classNameBindings: [
    'styleClass'
    'xs:btn-xs'
    'sm:btn-sm'
    'lg:btn-lg'
    'block:btn-block'
  ]
  attributeBindings: ['url:href', 'target']
  action: null
  url: null
  target: Ember.computed 'url', -> '_blank' if @get 'url'
  style: 'primary'
  xs: false
  sm: false
  lg: false
  block: false
  styleClass: Ember.computed 'style', -> "btn-#{@get 'style'}"
  click: -> @sendAction() if !@get 'disabled'

`export default BsButtonComponent`
