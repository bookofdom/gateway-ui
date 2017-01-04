`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`

ApCheckboxComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-checkbox form-control']
  classNameBindings: ['isChecked:checked']
  attributeBindings: ['checked']
  name: null
  checked: false
  isChecked: Ember.computed 'checked', -> @get 'checked'
  'icon-classes': Ember.computed 'checked', ->
    classes = []
    classes.push('invisible') if !@get 'checked'
    classes.join ' '

`export default ApCheckboxComponent`
