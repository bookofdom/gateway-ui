`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/pods/components/bs-base/component'`

ApIconComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-icon']
  attributeBindings: ['titleText:title']
  icon: null
  type: 'gateway-icon'
  style: 'primary'
  title: null
  iconClass: Ember.computed 'icon', ->
    type = @get 'type'
    prefix = type.replace '-icon', ''
    icon = @get 'icon'
    "#{type} #{prefix}-#{icon}" if icon
  titleText: Ember.computed 'title', ->
    @get('title')?.capitalize() if typeof @get('title') == 'string'

`export default ApIconComponent`
