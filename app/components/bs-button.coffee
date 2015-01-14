`import Ember from 'ember'`
`import BsTypographyComponent from 'gateway/components/bs-typography'`

BsButtonComponent = BsTypographyComponent.extend
  tagName: 'a'
  classNames: ['btn']
  classNameBindings: ['styleClass', 'sizeClass', 'active', 'disabled', 'block:btn-block']
  action: null
  style: 'primary'
  xs: false
  sm: false
  lg: false
  active: false
  disabled: false
  block: false
  styleClass: Ember.computed 'style', -> "btn-#{@get 'style'}"
  sizeClass: Ember.computed '{xs,sm,lg}', ->
    (for size in @get 'sizes'
      sizeClass = "btn-#{size}"
      sizeClass if @get size
    ).compact().join ' '
  click: -> @sendAction() if !@get 'disabled'

`export default BsButtonComponent`
