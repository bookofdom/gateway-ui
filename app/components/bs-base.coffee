`import Ember from 'ember'`

BsBaseComponent = Ember.Component.extend
  classNameBindings: [
    'disabled'
  ]
  sizes: ['xs', 'sm', 'md', 'lg']
  disabled: false

`export default BsBaseComponent`
