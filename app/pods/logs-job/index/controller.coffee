`import Ember from 'ember'`
`import LogsIndexController from 'gateway-ui/pods/logs/index/controller'`

LogsJobIndexController = LogsIndexController.extend
  logsController: Ember.inject.controller 'logs-job'

`export default LogsJobIndexController`
