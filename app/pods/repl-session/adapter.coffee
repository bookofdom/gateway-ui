`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

# Only one repl socket allowed in app.  That socket is kept here.
socket = null
socketUrl = null

ReplSessionAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'
  enabled: false

  missedHeartbeats: 0
  heartbeatEnabled: config.APP.wsHeartbeatsEnabled
  heartbeatStarted: false
  maxMissedHeartbeats: 4 # how many heartbeats may be missed before reconnecting?
  heartbeatInterval: Ember.computed ->
    intervalString = config.APP.wsHeartbeatInterval?.toString()
    parseInt(intervalString, 10) * 1000

  buildSocketURL: (replSession) ->
    environmentSnapshot = replSession.get('environment.content')._createSnapshot()
    environmentAdapter = @store.adapterFor 'environment'
    modelName = environmentSnapshot.record.constructor.modelName
    id = environmentSnapshot.id
    url = environmentAdapter.buildURL modelName, id, environmentSnapshot, 'GET'
    isSecure = (location.protocol is 'https:') or (url.match /^https:\/\//)
    url = url.replace /^[a-z]*:\/\//, '' # remove protocol
    url = "#{location.host}#{url}" if !config.api.host
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}"
    # replace double leading slash with single
    url = @cleanURL "#{url}/repl/socket"
    url

  enableStreaming: (replSession) ->
    url = @buildSocketURL replSession
    @set 'enabled', true
    @openSocket url

  disableStreaming: ->
    @set 'enabled', false
    @closeSocket()

  closeSocket: ->
    oldSocketUrl = socket?.socket?.url or socketUrl
    if oldSocketUrl
      @get('websockets').closeSocketFor socketUrl
      socket = null
      socketUrl = null
    @stopHeartbeats()

  openSocket: (url) ->
    @closeSocket()
    socketUrl = url
    newSocket = @get('websockets').socketFor url
    newSocket.on 'message', ((event) ->
      frame = JSON.parse event.data
      if !@isHeartbeat frame
        @trigger 'socketMessage', frame
      else
        @trigger 'socketHeartbeat'
    ), @
    socket = newSocket
    @startHeartbeats()

  onSocketMessage: Ember.on 'socketMessage', (frame) ->
    @print frame

  onSocketHeartbeat: Ember.on 'socketHeartbeat', ->
    @resetHeartbeats()

  print: (frame) ->
    replSessions = @store.peekAll 'repl-session'
    latestAll = replSessions.sortBy 'created'
    latest = latestAll.reverse()[0]
    latest.print frame

  evaluate: (text) ->
    if @get 'enabled'
      socket?.send text

  timeoutSocket: ->
    @set 'missedHeartbeats', 0
    @openSocket(socketUrl) if @get 'enabled'

  isHeartbeat: (frame) ->
    frame.type == 'heartbeat'

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

`export default ReplSessionAdapter`
