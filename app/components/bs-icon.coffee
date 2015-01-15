`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

BsIconComponent = BsBaseComponent.extend
  tagName: 'i'
  classNameBindings: ['iconClass']
  icon: null
  iconClass: Ember.computed 'icon', ->
    icon = @get 'icon'
    "retina-#{icon}" if icon

`export default BsIconComponent`
