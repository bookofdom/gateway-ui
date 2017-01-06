`import Ember from 'ember'`
`import LogsIndexController from 'gateway-ui/pods/logs/index/controller'`

LogsTimerIndexController = LogsIndexController.extend
  logsController: Ember.inject.controller 'logs-timer'

`export default LogsTimerIndexController`
