`import Ember from 'ember'`

BsBaseComponent = Ember.Component.extend
  classNameBindings: [
    'disabled'
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
