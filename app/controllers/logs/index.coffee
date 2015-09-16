`import Ember from 'ember'`

LogsIndexController = Ember.Controller.extend
  logs: Ember.inject.controller()
  actions:
    'toggle-streaming': ->
      streaming = @get 'logs.streaming'
      streaming = if streaming then '' else 'true' # because URL parameters
      @set 'logs.streaming', streaming

`export default LogsIndexController`
