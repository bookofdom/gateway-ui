`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApLogComponent = BsBaseComponent.extend
  tagName: 'pre'
  classNames: ['ap-log']
  value: null
  autoScroll: true

  scrollOnShow: Ember.on 'didInsertElement', -> @scrollToBottom()
  scrollOnValueChange: Ember.observer 'value', -> @scrollToBottom()

  scrollToBottom: ->
    Ember.run.later (=>
      if @get 'autoScroll'
        scrollHeight = @$()?[0]?.scrollHeight
        @$().scrollTop(scrollHeight + 200) if scrollHeight
    ), 250

`export default ApLogComponent`
