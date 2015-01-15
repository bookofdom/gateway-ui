`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsListLinkComponent = BsTextComponent.extend
  tagName: 'li'
  attributeBindings: ['role']
  path: null
  arg1: null
  role: 'presentation'

`export default BsListLinkComponent`
