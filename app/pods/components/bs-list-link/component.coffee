`import Ember from 'ember'`
`import BsTextComponent from 'gateway/pods/components/bs-text/component'`

BsListLinkComponent = BsTextComponent.extend
  tagName: 'li'
  action: null
  path: null
  arg1: null
  url: null
  download: false
  target: '_blank'
  click: (e) ->
    e.preventDefault() if !@get('path') and !@get('url')
    @sendAction 'action', @get('arg1') if !@get 'disabled'

`export default BsListLinkComponent`
