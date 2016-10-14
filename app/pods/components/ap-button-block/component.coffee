`import Ember from 'ember'`
`import BsButtonComponent from 'gateway/pods/components/bs-button/component'`

ApButtonBlockComponent = BsButtonComponent.extend
  classNames: ['ap-button-block']
  style: 'link'
  block: true

`export default ApButtonBlockComponent`
