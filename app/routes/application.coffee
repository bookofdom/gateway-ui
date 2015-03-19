`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway/helpers/slugify'`
`import config from  '../config/environment'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  afterModel: (first, transition) ->
    @checkSessionValidity transition
  checkSessionValidity: (transition) ->
    session = @get 'session'
    if session.authenticator
      isDevMode = config.meta['dev-mode']
      isDevAuth = session.authenticator is 'authenticator:dev-mode'
      # auto-invalidate if logged in with the wrong authenticator
      if (isDevMode and !isDevAuth) or (!isDevMode and isDevAuth)
        transition.send 'invalidateSession'
  actions:
    authenticateSession: ->
      # auto-login using dev mode authenticator if in dev mode
      if config.meta['dev-mode']
        @get('session').authenticate 'authenticator:dev-mode', {}
      else
        @transitionTo config['simple-auth'].routeAfterInvalidation
    sessionAuthenticationFailed: (error) ->
      message = slugify error
      loginController = @controllerFor('login')
      loginController.set 'authenticationError', message
    sessionInvalidationSucceeded: ->
      # redirect
      @transitionTo(config['simple-auth'].routeAfterInvalidation).then =>
        # refresh page (except in dev mode)
        @send 'reload' if !config.meta['dev-mode']
    reload: ->
      window.location.reload()
    localChange: (locale) ->
      window.location.search = "locale=#{locale}"

`export default ApplicationRoute`
