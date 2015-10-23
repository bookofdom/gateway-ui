`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway/helpers/slugify'`
`import config from  '../config/environment'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  notificationService: Ember.inject.service 'notification'
  notify: Ember.inject.service()

  isLoading: false
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
    session = @get 'session'
    notificationService = @get 'notificationService'
    # enable notifications for authenticated non-dev-mode sessions
    if session.isAuthenticated
      notificationService.on 'notification', (notification) =>
        @trigger 'notification', notification
      notificationService.enableNotifications()
  disableNotifications: ->
    notificationService = @get 'notificationService'
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
  # Instances marked as deleted will not be editable.  They will fall off
  # with the next reload of the resource.
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
          # mark as deleted
          resourceRecord.deleteRecord()

  authenticate: ->
    # auto-login using dev mode authenticator if in dev mode
    if config.meta['dev-mode']
      @get('session').authenticate 'authenticator:dev-mode', {}
    else
      @transitionTo config['simple-auth'].routeAfterInvalidation

  loadingObserver: Ember.observer 'isLoading', ->
    isLoading = @get 'isLoading'
    appController = @controller
    appController?.set 'isLoading', isLoading

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
    loading: ->
      @set 'isLoading', true
      true
    didTransition: ->
      Ember.run.later (=> @set 'isLoading', false), 1000
      true

`export default ApplicationRoute`
