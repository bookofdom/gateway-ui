`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApCheckboxComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-checkbox form-control']
  attributeBindings: ['checked']
  name: null
  checked: false
  'icon-classes': Ember.computed 'checked', ->
    classes = []
    classes.push('invisible') if !@get 'checked'
    classes.join ' '

`export default ApCheckboxComponent`
