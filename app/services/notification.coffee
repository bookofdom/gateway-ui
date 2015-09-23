`import Ember from 'ember'`

NotificationService = Ember.Object.extend Ember.Evented,
  adapter: null
  init: ->
    @_super.apply @, arguments
    store = @container.lookup 'store:main'
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
