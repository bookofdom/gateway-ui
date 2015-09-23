`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

# Only one notification socket allowed in app.  That socket is kept here.
socket = null

NotificationAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'

  buildSocketURL: (type) ->
    url = @urlForFindAll type
    url = url.replace 'http://', ''
    url = "#{location.host}#{url}" if !config.api.host
    "ws://#{url}"

  enableStreaming: ->
    url = @buildSocketURL 'notification'
    @openSocket url

  disableStreaming: -> @closeSocket()

  closeSocket: ->
    oldSocketUrl = socket?.socket?.url
    if oldSocketUrl
      @get('websockets').closeSocketFor oldSocketUrl

  openSocket: (url) ->
    @closeSocket()
    newSocket = @get('websockets').socketFor url
    newSocket.on 'message', ((event) -> @trigger 'socketMessage', event.data), @
    socket = newSocket

  onSocketMessage: Ember.on 'socketMessage', (payload) ->
    data = notifications: [JSON.parse payload]
    @store.pushPayload 'notification', data
    @triggerNotification()

  triggerNotification: ->
    notifications = @store.peekAll 'notification'
    latestAll = notifications.sortBy 'created'
    latest = latestAll[0]
    @trigger 'notification', latest

`export default NotificationAdapter`
