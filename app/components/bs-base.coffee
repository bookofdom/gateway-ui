`import Ember from 'ember'`

BsBaseComponent = Ember.Component.extend
  classNameBindings: [
    'disabled'
    'hiddenClasses'
    'pullClass'
    'textAlignmentClass'
  ]
  sizes: ['xs', 'sm', 'md', 'lg']
  stateNames: ['primary', 'success', 'info', 'warning', 'danger']
  disabled: false
  left: false
  right: false
  'text-left': false
  'text-right': false
  'text-center': false
  hiddenClasses: Ember.computed 'hidden-{xs,sm,md,lg}', ->
    (for size in @get 'sizes'
      hiddenClass = "hidden-#{size}"
      hiddenClass if @get hiddenClass
    ).compact().join ' '
  pullClass: Ember.computed '{left,right}', ->
    if @get 'left'
      'pull-left'
    else if @get 'right'
      'pull-right'
  textAlignmentClass: Ember.computed 'text-{left,right,center}', ->
    if @get 'text-left'
      'text-left'
    else if @get 'text-right'
      'text-right'
    else if @get 'text-center'
      'text-center'

`export default BsBaseComponent`
