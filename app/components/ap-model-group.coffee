`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

BsFormComponent = BsBaseComponent.extend
  tagName: 'div'
  classNameBindings: ['formTypeClass']
  inline: false
  horizontal: false
  formTypeClass: Ember.computed 'inline', 'horizontal', ->
    formTypeClass = 'form-inline' if @get 'inline'
    formTypeClass = 'form-horizontal' if @get 'horizontal'
    formTypeClass

`export default BsFormComponent`
