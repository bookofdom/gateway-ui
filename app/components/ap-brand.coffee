`import Ember from 'ember'`
`import BsTextComponent from 'gateway/components/bs-text'`
`import t from 'gateway/helpers/i18n'`

ApBrandComponent = BsTextComponent.extend
  tagName: 'span'
  classNames: ['ap-brand']
  classNameBindings: ['styleClass', 'brandClass']
  attributeBindings: ['text:title']
  brand: 'primary'
  t: Ember.computed 'brand', -> @get 'brand'
  style: 'default'
  styleClass: Ember.computed 'style', ->
    "ap-brand-#{@get 'style'}"
  brandClass: Ember.computed 'brand', ->
    "ap-brand-#{@get 'brand'}"
  text: Ember.computed 't', ->
    translationKey = @get 't'
    t("brands.#{translationKey}") if translationKey

`export default ApBrandComponent`
