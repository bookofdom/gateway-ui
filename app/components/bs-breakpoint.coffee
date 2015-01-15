`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

BsBreakpointComponent = BsBaseComponent.extend
  clearfix: true
  'visible-xs-block': Ember.computed 'xs', -> @get 'xs'
  'visible-sm-block': Ember.computed 'sm', -> @get 'sm'
  'visible-md-block': Ember.computed 'md', -> @get 'md'
  'visible-lg-block': Ember.computed 'lg', -> @get 'lg'

`export default BsBreakpointComponent`
