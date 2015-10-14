`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApLogComponent = BsBaseComponent.extend
  tagName: 'pre'
  classNames: ['ap-log']
  value: ''
  autoScroll: true

  scrollOnShow: Ember.on 'didInsertElement', -> @scrollToBottom()
  scrollOnValueChange: Ember.observer 'value', -> @scrollToBottom()

  scrollToBottom: ->
    if @get 'autoScroll'
      scrollHeight = @$()[0]?.scrollHeight
      @$().scrollTop scrollHeight if scrollHeight

`export default ApLogComponent`
