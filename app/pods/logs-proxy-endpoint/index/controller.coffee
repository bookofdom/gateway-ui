`import Ember from 'ember'`
`import LogsIndexController from 'gateway-ui/pods/logs/index/controller'`

LogsProxyEndpointIndexController = LogsIndexController.extend
  logsController: Ember.inject.controller 'logs-proxy-endpoint'

`export default LogsProxyEndpointIndexController`
