`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

sizes = ['xs', 'sm', 'lg']

BsButtonComponent = BsTextComponent.extend
  tagName: 'a'
  classNames: ['btn']
  classNameBindings: ['styleClass', 'sizeClass', 'block:btn-block']
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
  sizeClass: Ember.computed '{xs,sm,lg}', ->
    (for size in sizes
      sizeClass = "btn-#{size}"
      sizeClass if @get size
    ).compact().join ' '
  click: -> @sendAction() if !@get 'disabled'

`export default BsButtonComponent`
