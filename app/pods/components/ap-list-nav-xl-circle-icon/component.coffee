`import Ember from 'ember'`
`import ApListNavComponent from 'gateway-ui/pods/components/ap-list-nav/component'`

ApListNavXlCircleIconComponent = ApListNavComponent.extend
  classNames: ['ap-list-nav-xl-circle-icon text-center']
  xl: true
  inline: true
  circle: true
  'secondary-hover': true

`export default ApListNavXlCircleIconComponent`
