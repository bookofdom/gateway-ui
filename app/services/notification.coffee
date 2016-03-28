`import Ember from 'ember'`

NotificationService = Ember.Service.extend Ember.Evented,
  adapter: null
  store: Ember.inject.service()
  init: ->
    @_super arguments...
    store = @get 'store'
    adapter = store.adapterFor 'notification'
    adapter.on 'notification', (notification) =>
      @trigger 'notification', notification
    @set 'adapter', adapter
  enableNotifications: ->
    adapter = @get 'adapter'
    adapter.enableStreaming()
  disableNotifications: ->
    adapter = @get 'adapter'
    adapter.disableStreaming()

`export default NotificationService`
