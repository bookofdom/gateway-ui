`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsListLinkComponent = BsTextComponent.extend
  tagName: 'li'
  action: null
  path: null
  arg1: null
  click: -> @sendAction 'action', @get('arg1') if !@get 'disabled'

`export default BsListLinkComponent`
