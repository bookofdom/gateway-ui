`import Ember from 'ember'`
`import config from 'gateway-ui/config/environment'`

ApplicationController = Ember.Controller.extend Ember.Evented,
  version: config.version
  dev_mode: config.dev_mode?.toString() is 'true'
  session: Ember.inject.service()

  requestAppUpdate: false

`export default ApplicationController`
