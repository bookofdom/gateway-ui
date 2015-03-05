`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsButtonComponent = BsTextComponent.extend
  tagName: 'a'
  classNames: ['btn']
  classNameBindings: ['styleClass', 'sizeClass', 'block:btn-block']
  action: null
  style: 'primary'
  xs: false
  sm: false
  lg: false
  block: false
  styleClass: Ember.computed 'style', -> "btn-#{@get 'style'}"
  sizeClass: Ember.computed '{xs,sm,lg}', ->
    (for size in @get 'sizes'
      sizeClass = "btn-#{size}"
      sizeClass if @get size
    ).compact().join ' '
  click: -> @sendAction() if !@get 'disabled'

`export default BsButtonComponent`
