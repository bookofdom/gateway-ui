`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApIconComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-icon']
  icon: null
  style: 'primary'
  iconClass: Ember.computed 'icon', ->
    icon = @get 'icon'
    "retina-#{icon}" if icon

`export default ApIconComponent`
