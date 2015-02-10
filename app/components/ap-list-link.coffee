`import Ember from 'ember'`
`import BsListLinkComponent from 'gateway/components/bs-list-link'`

ApListLinkComponent = BsListLinkComponent.extend
  classNameBindings: ['circleClass', 'reversedClass', 'secondaryHoverClass']
  attributeBindings: ['index:data-index']
  circle: false
  reversed: false
  'secondary-hover': false
  index: null
  circleClass: Ember.computed 'circle', ->
    'ap-list-link-circle' if @get 'circle'
  reversedClass: Ember.computed 'reversed', ->
    'ap-list-link-reversed' if @get 'reversed'
  secondaryHoverClass: Ember.computed 'secondary-hover', ->
    'ap-list-link-secondary-hover' if @get 'secondary-hover'

`export default ApListLinkComponent`
