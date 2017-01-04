`import Ember from 'ember'`
`import LogsIndexController from 'gateway-ui/pods/logs/index/controller'`

LogsApiIndexController = LogsIndexController.extend
  logsController: Ember.inject.controller 'logs-api'

`export default LogsApiIndexController`
