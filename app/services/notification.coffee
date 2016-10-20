`import Ember from 'ember'`

NotificationService = Ember.Service.extend Ember.Evented,
  adapter: null
  store: Ember.inject.service()
  enabled: Ember.computed ->
    Ember.getOwner(@).application.notifications
  init: ->
    @_super arguments...
    if @get 'enabled'
      store = @get 'store'
      adapter = store.adapterFor 'notification'
      adapter.on 'notification', (notification) =>
        @trigger 'notification', notification
      @set 'adapter', adapter
  enableNotifications: ->
    if @get 'enabled'
      adapter = @get 'adapter'
      adapter.enableStreaming()
  disableNotifications: ->
    if @get 'enabled'
      adapter = @get 'adapter'
      adapter.disableStreaming()

`export default NotificationService`
