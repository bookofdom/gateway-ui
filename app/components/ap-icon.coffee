`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApIconComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-icon']
  attributeBindings: ['titleText:title']
  icon: null
  style: 'primary'
  title: null
  iconClass: Ember.computed 'icon', ->
    icon = @get 'icon'
    "retina-#{icon}" if icon
  titleText: Ember.computed 'title', ->
    @get('title')?.capitalize() if typeof @get('title') == 'string'

`export default ApIconComponent`
