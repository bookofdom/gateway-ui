`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`
`import { brandName } from 'gateway-ui/helpers/brand-name'`

ApBrandComponent = BsBaseComponent.extend
  tagName: 'span'
  classNames: ['ap-brand']
  classNameBindings: ['styleClass', 'brandClass']
  attributeBindings: ['name:title']
  brand: 'primary'
  style: 'default'
  styleClass: Ember.computed 'style', ->
    "ap-brand-#{@get 'style'}"
  brandClass: Ember.computed 'brand', ->
    "ap-brand-#{@get 'brand'}"
  name: Ember.computed 'brand', ->
    brand = @get 'brand'
    brandName [brand]

`export default ApBrandComponent`
