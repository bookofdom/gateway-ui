`import Ember from 'ember'`

LogsIndexController = Ember.Controller.extend
  logsController: Ember.inject.controller 'logs'
  actions:
    'toggle-streaming': ->
      streaming = @get 'logsController.streaming'
      streaming = if streaming then '' else 'true' # because URL parameters
      @set 'logsController.streaming', streaming

`export default LogsIndexController`
