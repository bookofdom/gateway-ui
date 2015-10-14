`import Ember from 'ember'`
`import LogsIndexController from '../logs/index'`

LogsProxyEndpointIndexController = LogsIndexController.extend
  logsController: Ember.inject.controller 'logs-proxy-endpoint'

`export default LogsProxyEndpointIndexController`
