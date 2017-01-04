`import Ember from 'ember'`
`import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway-ui/helpers/slugify'`
`import config from  'gateway-ui/config/environment'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  notificationService: Ember.inject.service 'notification'
  notify: Ember.inject.service()
  session: Ember.inject.service()
  appVersion: Ember.inject.service 'app-version'

  isLoading: false
  isDevMode: config.dev_mode?.toString() is 'true'

  topLevelResourceNames: [
    'api'
    'push-device'
    'push-channel-message'
  ]

  afterModel: (first, transition) ->
    @checkSessionValidity transition
    @setupNotifications()

  checkSessionValidity: (transition) ->
    session = @get 'session'
    authenticator = session.get 'session.authenticated.authenticator'
    isDevMode = @get 'isDevMode'
    isDevAuth = authenticator is 'authenticator:dev-mode'
    if authenticator and (isDevMode != isDevAuth)
      # auto-invalidate if logged in with the wrong authenticator
      transition.send 'invalidateSession'
    else if !authenticator and isDevMode
      # auto-login using dev-mode authenticator if dev mode is active
      @get('session').authenticate 'authenticator:dev-mode', {}

  sessionInvalidated: -> @reloadApp()
  sessionAuthenticated: ->
    @setupNotifications()
    @_super arguments...

  setupNotifications: ->
    session = @get 'session'
    notificationService = @get 'notificationService'
    # enable notifications for authenticated non-dev-mode sessions
    if session.get('isAuthenticated')
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
    if notification.get 'isDisplayed'
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
      if @topLevelResourceNames.includes type
        Ember.run.later (=> @store.findAll type), 1000
      else
        index.reload()
    else if resourceIsLoaded
      switch action
        when 'create', 'update'
          # cancel does two things:  reload and rollback
          resourceRecord.cancel()
        when 'delete'
          # mark as deleted
          resourceRecord.deleteRecord()

  loadingObserver: Ember.observer 'isLoading', ->
    isLoading = @get 'isLoading'
    appController = @controller
    appController?.set 'isLoading', isLoading

  setupAppVersionHandler: Ember.on 'init', ->
    appVersion = @get 'appVersion' # force service startup
    appVersion.on 'newRelease', => @trigger 'newRelease'

  onNewRelease: Ember.on 'newRelease', ->
    if @get('session.isAuthenticated') and !Ember.testing
      appController = @controller
      appController?.set 'requestAppUpdate', true
    else
      # not logged in, so just do the reload
      @reloadApp()

  reloadApp: ->
    # reload, but only if not in testing mode
    # reloading during testing causes all sorts of problems
    window?.location?.reload() if !Ember.testing

  actions:
    invalidateSession: ->
      @get('session').invalidate()
    localChange: (locale) ->
      window.location.search = "locale=#{locale}"
    loading: ->
      @set 'isLoading', true
      true
    didTransition: ->
      Ember.run.later (=> @set 'isLoading', false), 1000
      true
    confirmReload: ->
      @reloadApp()
    cancelReload: ->
      appController = @controller
      appController?.set 'requestAppUpdate', false

`export default ApplicationRoute`
