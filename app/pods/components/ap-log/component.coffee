`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`

# https://github.com/chalk/ansi-regex
ansiRegex = /[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g

ApLogComponent = BsBaseComponent.extend
  tagName: 'pre'
  classNames: ['ap-log']
  value: null
  output: ''
  reset: 0
  cursorPosition: 0
  selectionSize: 80 * 50 # conventional line length * number of lines
  speedMs: 250
  # interation delay when log remains to be shown
  workingSpeed: 250
  # iteration delay when no log currently remains (though more could be added)
  idleSpeed: 750

  appendOnShow: Ember.on 'didInsertElement', -> @runAppend()

  valueObserver: Ember.observer 'value', ->
    cursorPosition = @get 'cursorPosition'
    value = @get 'value'
    if value?.length < cursorPosition
      @set 'output', ''
      @set 'cursorPosition', 0

  runAppend: ->
    speedMs = @get 'speedMs'
    Ember.run.later (=>
      if !@get('isDestroyed') and !@get('isDestroying')
        value = @get 'value'
        value = value.replace(ansiRegex, '')
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
          output = @get 'output'
          output = output.concat selection
          @set 'output', output
          @set 'speedMs', @get('workingSpeed')
        else
          # if nothing remains, slow things down
          @set 'speedMs', @get('idleSpeed')
        @runAppend() # and repeat
    ), speedMs

  scrollToBottom: Ember.on 'didUpdate', ->
    scrollHeight = @$()?[0]?.scrollHeight
    @$().scrollTop(scrollHeight + 200) if scrollHeight

`export default ApLogComponent`
