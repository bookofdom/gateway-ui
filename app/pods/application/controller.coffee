`import Ember from 'ember'`
`import config from 'gateway/config/environment'`

ApplicationController = Ember.Controller.extend
  version: config.version
  dev_mode: config.dev_mode?.toString() is 'true'
  session: Ember.inject.service()

`export default ApplicationController`
