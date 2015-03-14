`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApIconComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-icon']
  attributeBindings: ['titleText:title']
  icon: null
  type: 'retina'
  style: 'primary'
  title: null
  iconClass: Ember.computed 'icon', ->
    type = @get 'type'
    icon = @get 'icon'
    "#{type} #{type}-#{icon}" if icon
  titleText: Ember.computed 'title', ->
    @get('title')?.capitalize() if typeof @get('title') == 'string'

`export default ApIconComponent`
