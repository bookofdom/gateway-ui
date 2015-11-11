`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

BsFormComponent = BsBaseComponent.extend
  tagName: 'form'
  classNameBindings: ['inline:form-inline', 'horizontal:form-horizontal']
  inline: false
  horizontal: false

`export default BsFormComponent`
