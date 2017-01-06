`import Ember from 'ember'`

LogsIndexController = Ember.Controller.extend
  logsController: Ember.inject.controller 'logs'
  isStreaming: Ember.computed.bool 'logsController.streaming'
  enableStreaming: ->
    if !@get 'isStreaming'
      @set('logsController.streaming', 'true') # because URL parameters
  disableStreaming: ->
    if @get 'isStreaming'
      @set('logsController.streaming', '') # because URL parameters

  actions:
    'toggle-streaming': ->
      if !@get 'isStreaming'
        @enableStreaming()
      else
        @disableStreaming()

`export default LogsIndexController`
