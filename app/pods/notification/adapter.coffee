`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

# Only one notification socket allowed in app.  That socket is kept here.
socket = null
socketUrl = null

NotificationAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'
  autoReconnect: true
  enabled: false

  missedHeartbeats: 0
  heartbeatEnabled: config.APP.wsHeartbeatsEnabled
  heartbeatStarted: false
  maxMissedHeartbeats: 4 # how many heartbeats may be missed before reconnecting?
  heartbeatInterval: Ember.computed ->
    intervalString = config.APP.wsHeartbeatInterval?.toString()
    parseInt(intervalString, 10) * 1000

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
    @stopHeartbeats()

  openSocket: (url) ->
    @closeSocket()
    socketUrl = url
    newSocket = @get('websockets').socketFor url
    newSocket.on 'message', ((event) ->
      if !@isHeartbeat event.data
        @trigger 'socketMessage', event.data
      else
        @trigger 'socketHeartbeat'
    ), @
    newSocket.on 'close', (-> @trigger 'socketClose'), @
    socket = newSocket
    @startHeartbeats()

  onSocketMessage: Ember.on 'socketMessage', (payload) ->
    data = notifications: [JSON.parse payload]
    @store.pushPayload data
    @triggerNotification()

  onSocketClose: Ember.on 'socketClose', ->
    if @get('enabled') and @get('autoReconnect')
      Ember.run.later (-> socket.reconnect()), 1000

  onSocketHeartbeat: Ember.on 'socketHeartbeat', ->
    @resetHeartbeats()

  triggerNotification: ->
    notifications = @store.peekAll 'notification'
    latestAll = notifications.sortBy 'created'
    latest = latestAll.reverse()[0]
    @trigger 'notification', latest

  timeoutSocket: ->
    @set 'missedHeartbeats', 0
    @closeSocket()
    @openSocket socketUrl

  isHeartbeat: (frame) ->
    frame == 'heartbeat'

  resetHeartbeats: ->
    @set 'missedHeartbeats', 0

  startHeartbeats: ->
    if @get 'heartbeatEnabled'
      @resetHeartbeats()
      @set 'heartbeatStarted', true
      @doHeartbeat()

  stopHeartbeats: (model) ->
    @resetHeartbeats()
    @set 'heartbeatStarted', false

  doHeartbeat: ->
    interval = @get 'heartbeatInterval'
    Ember.run.later (=>
      if @get 'heartbeatStarted'
        missedHeartbeats = @get 'missedHeartbeats'
        maxMissed = @get 'maxMissedHeartbeats'
        @set 'missedHeartbeats', ++missedHeartbeats
        if missedHeartbeats >= maxMissed
          @timeoutSocket()
        Ember.run.debounce @, @doHeartbeat, 1000
    ), interval

`export default NotificationAdapter`
