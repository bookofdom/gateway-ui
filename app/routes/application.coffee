`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway/helpers/slugify'`
`import config from  '../config/environment'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  actions:
    sessionAuthenticationFailed: (error) ->
      message = slugify error
      loginController = @controllerFor('login')
      loginController.set 'authenticationError', message
    sessionInvalidationSucceeded: ->
      # redirect
      @transitionTo config['simple-auth'].routeAfterInvalidation
      # refresh page
      @send 'reload'
    reload: ->
      window.location.reload()

`export default ApplicationRoute`
