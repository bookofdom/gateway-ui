`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApListNavComponent = BsBaseComponent.extend
  tagName: 'ul'
  classNames: ['ap-list-nav', 'list-unstyled']
  classNameBindings: [
    'sizeClass'
    'inlineClass'
    'circleClass'
    'secondaryHoverClass'
    'showTextClass'
  ]
  xs: false
  sm: false
  lg: false
  xl: false
  inline: false
  circle: false
  'secondary-hover': false
  'show-text': true
  sizeClass: Ember.computed '{xs,sm,lg,xl}', ->
    sizes = @get('sizes').slice()
    sizes.push 'xl'
    (for size in sizes
      sizeClass = "ap-list-nav-#{size}"
      sizeClass if @get sizeClass
    ).compact().join ' '
  inlineClass: Ember.computed 'inline', -> 'list-inline' if @get 'inline'
  circleClass: Ember.computed 'circle', -> 'ap-list-nav-circle' if @get 'circle'
  secondaryHoverClass: Ember.computed 'secondary-hover', ->
    'ap-list-nav-secondary-hover' if @get 'secondary-hover'
  showTextClass: Ember.computed 'show-text', ->
    'ap-list-nav-hide-text' if !@get 'show-text'

`export default ApListNavComponent`
