`import Ember from 'ember'`
`import config from '../config/environment'`

ApplicationController = Ember.Controller.extend
  meta: Ember.computed -> config.meta

`export default ApplicationController`
