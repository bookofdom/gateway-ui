`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/pods/components/bs-base/component'`

ApLogComponent = BsBaseComponent.extend
  tagName: 'pre'
  classNames: ['ap-log']
  value: null
  cursorPosition: 0
  selectionSize: 80 * 50 # conventional line length * number of lines
  speedMs: 250
  # interation delay when log remains to be shown
  workingSpeed: 250
  # iteration delay when no log currently remains (though more could be added)
  idleSpeed: 750

  appendOnShow: Ember.on 'didInsertElement', -> @runAppend()

  runAppend: ->
    speedMs = @get 'speedMs'
    Ember.run.later (=>
      if !@get('isDestroyed') and !@get('isDestroying')
        value = @get 'value'
        length = value.length
        cursorPosition = @get 'cursorPosition'
        remaining = length - cursorPosition
        selectionSize = @get 'selectionSize'
        selectionSize = remaining if remaining < selectionSize
        x1 = cursorPosition
        x2 = x1 + selectionSize
        if remaining > 0
          selection = value.slice x1, x2
          @set 'cursorPosition', x2
          @$().append selection
          @scrollToBottom()
          @set 'speedMs', @get('workingSpeed')
        else
          # if nothing remains, slow things down
          @set 'speedMs', @get('idleSpeed')
        @runAppend() # and repeat
    ), speedMs

  scrollToBottom: ->
    scrollHeight = @$()?[0]?.scrollHeight
    @$().scrollTop(scrollHeight + 200) if scrollHeight

`export default ApLogComponent`
