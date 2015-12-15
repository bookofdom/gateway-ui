`import Ember from 'ember'`

ApIframeComponent = Ember.Component.extend
  tagName: 'iframe'
  classNames: ['ap-iframe']
  attributeBindings: ['src', 'seamless']
  src: null
  seamless: true

  autoHeight: Ember.on 'didInsertElement', ->
    @$().on 'load', ->
      scrollHeight = this.contentDocument.body.scrollHeight
      this.style.height = "#{scrollHeight}px"

`export default ApIframeComponent`
