`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsListLinkComponent = BsTextComponent.extend
  tagName: 'li'
  action: null
  path: null
  arg1: null
  click: -> @sendAction() if !@get 'disabled'

`export default BsListLinkComponent`