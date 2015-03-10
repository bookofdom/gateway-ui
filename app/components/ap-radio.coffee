`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApRadioComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-radio']
  classNameBindings: ['isChecked:checked']
  name: null
  value: null
  checked: null
  isChecked: Ember.computed 'value', 'checked', ->
    @get('value') == @get('checked')
  click: ->
    value = @get 'value'
    @set 'checked', value

`export default ApRadioComponent`
