`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`

ApIconComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-icon']
  attributeBindings: ['title:title']
  icon: null
  type: 'gateway-icon'
  style: 'primary'
  title: null
  iconClass: Ember.computed 'icon', ->
    type = @get 'type'
    prefix = type.replace '-icon', ''
    icon = @get 'icon'
    "#{type} #{prefix}-#{icon}" if icon

`export default ApIconComponent`
