`import Ember from 'ember'`

NotificationService = Ember.Object.extend
  adapter: null
  init: ->
    @_super.apply @, arguments
    store = @container.lookup 'store:main'
    adapter = store.adapterFor 'notification'
    adapter.on 'notification', @onNotification, @
    @set 'adapter', adapter
  enableNotifications: ->
    adapter = @get 'adapter'
    adapter.enableStreaming()
  disableNotifications: ->
    adapter = @get 'adapter'
    adapter.disableStreaming()
  onNotification: (notification) ->
    console.log notification

`export default NotificationService`
