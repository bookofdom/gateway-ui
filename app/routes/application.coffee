`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway/helpers/slugify'`
`import config from  '../config/environment'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  notificationService: Ember.inject.service 'notification'
  notify: Ember.inject.service()

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
      notificationService.on 'notification', (notification) =>
        @trigger 'notification', notification
      notificationService.enableNotifications()
  disableNotifications: ->
    isDevMode = @get 'isDevMode'
    notificationService = @get 'notificationService'
    if !isDevMode
      notificationService.off 'notification'
      notificationService.disableNotifications()
  onNotification: Ember.on 'notification', (notification) ->
    # notify user of change
    message = notification.get('message')
    if notification.get 'isDeleted'
      @get('notify').error message
    else
      @get('notify').info message
    # refresh resource
    @refreshResourceForNotification notification
  # Handles reloading of model(s) that received notification.
  # on create/update:
  #   - both instance and index are unloaded:  do nothing
  #   - index is loaded, instance is not:  reload index
  #   - instance is loaded:  reload instance
  # on delete:
  #   - both instance and index are unloaded: do nothing
  #   - index is loaded, instance is not:  reload index
  #   - instance is loaded:  mark as deleted
  #
  # Instances marked as deleted should not be editable.  They will fall off
  # with the next reload of the resource.  UI needs an indication of deletion.
  refreshResourceForNotification: (notification) ->
    type = notification.get 'resourceType'
    action = notification.get 'action'
    resourceRecord = notification.get 'resourceRecord'
    index = @modelFor type.pluralize()
    resourceIsLoaded = notification.get 'resourceIsLoaded'
    indexIsLoaded = index?
    if indexIsLoaded and !resourceIsLoaded
      index.reload()
    else if resourceIsLoaded
      switch action
        when 'create', 'update'
          # cancel does two things:  reload and rollback
          resourceRecord.cancel()
        when 'delete'
          # mark as deleted (see mark as delete mixin)
          resourceRecord.deleteRecord()

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
      # stop notifications
      @disableNotifications()
      # redirect
      @transitionTo(config['simple-auth'].routeAfterInvalidation).then =>
        if !isDevMode
          # refresh page (except in dev mode)
          @send 'reload'
    reload: ->
      window.location.reload()
    localChange: (locale) ->
      window.location.search = "locale=#{locale}"

`export default ApplicationRoute`
