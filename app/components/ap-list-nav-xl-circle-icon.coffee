`import Ember from 'ember'`
`import ApListNavComponent from 'gateway/components/ap-list-nav'`

ApListNavXlCircleIconComponent = ApListNavComponent.extend
  classNames: ['ap-list-nav-xl-circle-icon']
  xl: true
  inline: true
  circle: true
  'secondary-hover': true
  'text-center': true

`export default ApListNavXlCircleIconComponent`
