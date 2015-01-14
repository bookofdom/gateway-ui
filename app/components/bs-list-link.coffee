`import Ember from 'ember'`
`import BsTypographyComponent from 'gateway/components/bs-typography'`

BsListLinkComponent = BsTypographyComponent.extend
  tagName: 'li'
  attributeBindings: ['role']
  path: null
  arg1: null
  role: 'presentation'

`export default BsListLinkComponent`
