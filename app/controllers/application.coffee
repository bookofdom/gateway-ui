`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  version: config.version
  devMode: config.devMode?.toString() is 'true'

`export default ApplicationController`
