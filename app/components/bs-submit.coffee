`import Ember from 'ember'`
`import BsButtonComponent from 'gateway/components/bs-button'`

BsSubmitComponent = BsButtonComponent.extend
  tagName: 'button'
  attributeBindings: ['type']
  type: 'submit'

`export default BsSubmitComponent`
