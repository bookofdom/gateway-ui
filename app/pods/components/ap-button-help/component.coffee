`import Ember from 'ember'`
`import BsButtonComponent from 'gateway-ui/pods/components/bs-button/component'`

ApButtonHelpComponent = BsButtonComponent.extend
  classNames: ['ap-button-help']
  t: 'nav.help'
  icon: 'communication-043'
  'show-text': false
  style: 'link'
  lg: true
  url: null

`export default ApButtonHelpComponent`
