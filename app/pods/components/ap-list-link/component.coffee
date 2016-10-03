`import Ember from 'ember'`
`import BsListLinkComponent from 'gateway/pods/components/bs-list-link/component'`

ApListLinkComponent = BsListLinkComponent.extend
  classNameBindings: [
    'circle:ap-list-link-circle'
    'reversed:ap-list-link-reversed'
    'secondary-hover:ap-list-link-secondary-hover'
  ]
  attributeBindings: ['index:data-index']
  circle: false
  reversed: false
  'secondary-hover': false
  index: null

`export default ApListLinkComponent`
