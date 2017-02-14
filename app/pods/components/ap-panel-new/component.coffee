`import Ember from 'ember'`
`import BsPanelComponent from 'gateway-ui/pods/components/bs-panel/component'`

ApPanelNewComponent = BsPanelComponent.extend
  classNames: ['ap-panel-new']
  collapse: true
  style: 'success'
  icon: 'the-essentials-010'

`export default ApPanelNewComponent`
