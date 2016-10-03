`import ApplicationAdapter from 'gateway/pods/application/adapter'`
`import config from  'gateway/config/environment'`

# Only one notification socket allowed in app.  That socket is kept here.
socket = null

NotificationAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'
  autoReconnect: true
  enabled: false

  buildSocketURL: (type) ->
    url = @urlForFindAll type
    isSecure = (location.protocol is 'https:') or (url.match /^https:\/\//)
    url = url.replace /^[a-z]*:\/\//, '' # remove protocol
    url = "#{location.host}#{url}" if !config.api.host
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}"
    # replace double leading slash with single
    url = @cleanURL url
    url

  enableStreaming: ->
    url = @buildSocketURL 'notification'
    @set 'enabled', true
    @openSocket url

  disableStreaming: ->
    @set 'enabled', false
    @closeSocket()

  closeSocket: ->
    oldSocketUrl = socket?.socket?.url
    if oldSocketUrl
      @get('websockets').closeSocketFor oldSocketUrl

  openSocket: (url) ->
    @closeSocket()
    newSocket = @get('websockets').socketFor url
    newSocket.on 'message', ((event) -> @trigger 'socketMessage', event.data), @
    newSocket.on 'close', (-> @trigger 'socketClose'), @
    socket = newSocket

  onSocketMessage: Ember.on 'socketMessage', (payload) ->
    data = notifications: [JSON.parse payload]
    @store.pushPayload data
    @triggerNotification()

  onSocketClose: Ember.on 'socketClose', ->
    if @get('enabled') and @get('autoReconnect')
      Ember.run.later (-> socket.reconnect()), 1000

  triggerNotification: ->
    notifications = @store.peekAll 'notification'
    latestAll = notifications.sortBy 'created'
    latest = latestAll.reverse()[0]
    @trigger 'notification', latest

`export default NotificationAdapter`
