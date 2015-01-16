`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApIconComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-icon']
  classNameBindings: ['sizeClass']
  icon: null
  style: 'primary'
  xs: false
  sm: false
  lg: false
  xl: false
  iconClass: Ember.computed 'icon', ->
    icon = @get 'icon'
    "retina-#{icon}" if icon
  sizeClass: Ember.computed '{xs,sm,lg,xl}', ->
    sizes = @get('sizes').slice()
    sizes.push 'xl'
    (for size in sizes
      sizeClass = "ap-icon-#{size}"
      sizeClass if @get size
    ).compact().join ' '

`export default ApIconComponent`
