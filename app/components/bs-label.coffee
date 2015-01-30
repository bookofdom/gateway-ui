`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`

BsLabelComponent = BsTextComponent.extend
  tagName: 'span'
  classNames: ['label']
  classNameBindings: ['styleClass']
  style: 'default'
  styleClass: Ember.computed 'style', -> "label-#{@get 'style'}"

`export default BsLabelComponent`
