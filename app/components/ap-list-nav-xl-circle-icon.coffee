`import Ember from 'ember'`
`import ApListNavComponent from 'gateway/components/ap-list-nav'`

ApListNavXlCircleIconComponent = ApListNavComponent.extend
  classNames: ['ap-list-nav-xl-circle-icon text-center']
  xl: true
  inline: true
  circle: true
  'secondary-hover': true

`export default ApListNavXlCircleIconComponent`
