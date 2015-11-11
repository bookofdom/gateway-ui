`import Ember from 'ember'`

BsBaseComponent = Ember.Component.extend
  classNameBindings: [
    'disabled'
    'pullClass'
  ]
  sizes: ['xs', 'sm', 'md', 'lg']
  disabled: false
  left: false
  right: false
  pullClass: Ember.computed '{left,right}', ->
    if @get 'left'
      'pull-left'
    else if @get 'right'
      'pull-right'

`export default BsBaseComponent`
