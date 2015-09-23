`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway/helpers/slugify'`
`import config from  '../config/environment'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  notificationService: Ember.inject.service 'notification'

  isDevMode: config.meta['dev-mode']

  afterModel: (first, transition) ->
    @checkSessionValidity transition
    @enableNotifications()

  checkSessionValidity: (transition) ->
    session = @get 'session'
    if session.authenticator
      isDevMode = @get 'isDevMode'
      isDevAuth = session.authenticator is 'authenticator:dev-mode'
      # auto-invalidate if logged in with the wrong authenticator
      if (isDevMode and !isDevAuth) or (!isDevMode and isDevAuth)
        transition.send 'invalidateSession'

  enableNotifications: ->
    isDevMode = @get 'isDevMode'
    session = @get 'session'
    notificationService = @get 'notificationService'
    # enable notifications for authenticated non-dev-mode sessions
    if !isDevMode and session.isAuthenticated
      notificationService.enableNotifications()

  authenticate: ->
    # auto-login using dev mode authenticator if in dev mode
    if config.meta['dev-mode']
      @get('session').authenticate 'authenticator:dev-mode', {}
    else
      @transitionTo config['simple-auth'].routeAfterInvalidation
  actions:
    sessionRequiresAuthentication: ->
      @authenticate()
    authenticateSession: ->
      # for older versions of simple-auth
      @authenticate()
    sessionAuthenticationSucceeded: ->
      @enableNotifications()
      @_super.apply @, arguments
    sessionAuthenticationFailed: (error) ->
      message = slugify error
      loginController = @controllerFor('login')
      loginController.set 'authenticationError', message
    sessionInvalidationSucceeded: ->
      isDevMode = @get 'isDevMode'
      notificationService = @get 'notificationService'
      # redirect
      @transitionTo(config['simple-auth'].routeAfterInvalidation).then =>
        if !isDevMode
          # stop notifications
          notificationService.disableNotifications()
          # refresh page (except in dev mode)
          @send 'reload'
    reload: ->
      window.location.reload()
    localChange: (locale) ->
      window.location.search = "locale=#{locale}"

`export default ApplicationRoute`
