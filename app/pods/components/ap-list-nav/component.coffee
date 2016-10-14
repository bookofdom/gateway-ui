`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/pods/components/bs-base/component'`

ApListNavComponent = BsBaseComponent.extend
  tagName: 'ul'
  classNames: ['ap-list-nav', 'list-unstyled']
  classNameBindings: [
    'xs:ap-list-nav-xs'
    'sm:ap-list-nav-sm'
    'lg:ap-list-nav-lg'
    'xl:ap-list-nav-xl'
    'inline:list-inline'
    'circle:ap-list-nav-circle'
    'secondary-hover:ap-list-nav-secondary-hover'
    'show-text::ap-list-nav-hide-text'
  ]
  xs: false
  sm: false
  lg: false
  xl: false
  inline: false
  circle: false
  'secondary-hover': false
  'show-text': true

`export default ApListNavComponent`
