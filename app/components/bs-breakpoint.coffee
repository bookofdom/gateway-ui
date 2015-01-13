`import Ember from 'ember'`
`import BsClearfixComponent from 'gateway/components/bs-clearfix'`

BsBreakpointComponent = BsClearfixComponent.extend
  classNames: 'clearfix'
  'visible-xs-block': Ember.computed 'xs', -> @get 'xs'
  'visible-sm-block': Ember.computed 'sm', -> @get 'sm'
  'visible-md-block': Ember.computed 'md', -> @get 'md'
  'visible-lg-block': Ember.computed 'lg', -> @get 'lg'

`export default BsBreakpointComponent`
