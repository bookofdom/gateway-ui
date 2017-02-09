`import Ember from 'ember'`

ApReplTerminalComponent = Ember.Component.extend
  classNames: ['ap-repl-terminal']
  replSession: null # reference to repl model, which handles backend connection
  prompt: '> ' # can be anything
  inputBuffer: '' # user's working input
  # inputHistory is an array of previously evaluated inputs
  # (for up/down quick access)
  inputHistory: null
  inputHistoryPosition: null # track which input history item we're on
  evaluateAction: 'evaluate'
  commandAction: 'command'
  changeEnvironmentAction: 'changeEnvironment'
  onInit: Ember.on 'didInsertElement', ->
    @set 'inputHistory', []
    @print '<span class=\"text-info\">REPL started</span>'
    @print "&nbsp;&nbsp;/clear<span class=\"text-info\"> or </span>(CTL or CMD)+K<span class=\"text-info\"> to clear terminal</span>"
    @print "&nbsp;&nbsp;/e environment_name<span class=\"text-info\"> to switch environments</span>"
    @print()
    @printEnvironment()
    @focus()
  onSessionChange: Ember.observer 'replSession', -> @printEnvironment()
  # when model frameText changes, determine the best way to format it
  # and then print it to output
  onReplTextChange: Ember.observer 'replSession.frameText', ->
    text = @get 'replSession.frameText'
    isError = @get 'replSession.frameError'
    if isError
      @printError text
    else
      @printJavaScript text
  printError: (text) ->
    @print "<span class=\"text-danger\">#{text}</span>"
  # prints name of selected environment
  printEnvironment: ->
    environmentName = @get 'replSession.environment.name'
    @print "<span class=\"text-info\">Environment:  #{environmentName}</span>"
  printJavaScript: (text='') ->
    @print @syntaxHighlight text
  # prints arbitrary text to the terminal
  print: (text='') ->
    Ember.run =>
      pre = @$ '.terminal .output pre'
      pre.append text
      pre.append '\n'
    @scrollToBottom()
  syntaxHighlight: (text) ->
    hljs.highlight('javascript', text).value
  # clear all text from the terminal
  clear: ->
    Ember.run =>
      pre = @$ '.terminal .output pre'
      pre.empty()
  # place the cursor in the input
  focus: ->
    Ember.run =>
      @$('.terminal input').focus()
  # scroll terminal to bottom of text
  scrollToBottom: ->
    Ember.run =>
      output = @$ '.terminal .output'
      pre = @$ '.terminal .output pre'
      scrollHeight = pre?[0]?.scrollHeight
      output.scrollTop(scrollHeight + 200) if scrollHeight
  # scroll input history by arbitrary number of steps
  scrollInputHistory: (steps) ->
    history = @get 'inputHistory'
    position = @get 'inputHistoryPosition'
    isDown = steps < 0
    index = Math.abs((position + steps) % history.length)
    # In order to scroll, there must be history to scroll through
    # and you must not scroll down past the end of the list.
    # However, you can scroll up infinitely.
    if (history.length > 0) and !(isDown and ((position % history.length) == 0))
      value = history.slice().reverse()[index]
      @set 'inputBuffer', value
      @set 'inputHistoryPosition', (position + steps)
    else
      # reset position if scroll was rejected
      @set 'inputHistoryPosition', null
  scrollInputHistoryUp: ->
    position = @get 'inputHistoryPosition'
    if position == null
      @set 'inputHistoryPosition', -1
    @scrollInputHistory 1
  scrollInputHistoryDown: ->
    position = @get 'inputHistoryPosition'
    if position == null
      @set 'inputHistoryPosition', 0
    @scrollInputHistory -1
  click: ->
    @scrollToBottom()
    @focus()
  keyDown: (e) ->
    # CMD+K to clear
    if (e.metaKey or e.ctrlKey) and (e.keyCode is 75)
      e.preventDefault()
      @clear()
    # up to scroll through history
    if e.keyCode is 38
      e.preventDefault()
      @scrollInputHistoryUp()
    # down to scroll through history
    else if e.keyCode is 40
      e.preventDefault()
      @scrollInputHistoryDown()
    # else any other key resets history position
    else
      @set 'inputHistoryPosition', null
  actions:
    evaluate: ->
      prompt = @get 'prompt'
      input = @get 'inputBuffer'
      parsed = input.match /^\/([a-z]*)\s?(.*)?/
      command = parsed?[1]
      commandArgs = parsed?[2]
      @set 'inputBuffer', ''
      @get('inputHistory').push input
      if command
        @send 'command', command, commandArgs
      else if input
        @print "#{prompt}#{@syntaxHighlight input}"
        @sendAction 'evaluateAction', input
    command: (command, args) ->
      switch command
        when 'e', 'environment'
          @sendAction 'changeEnvironmentAction', args
        when 'c', 'clear'
          @clear()
        else
          @printError "Command not found:  /#{command}"
    fullscreen: ->
      Ember.run =>
        el = @$('.terminal')[0]
        el.requestFullscreen?()
        el.msRequestFullscreen?()
        el.mozRequestFullScreen?()
        el.webkitRequestFullscreen?()

`export default ApReplTerminalComponent`
