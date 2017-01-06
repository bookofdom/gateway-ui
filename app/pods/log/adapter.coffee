`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

# Only one log socket allowed in app.  That socket is kept here.
# Record updating is handled by the adapter, so the record is stored here.
# These are kept outside of the adapter class since adapters are disposable.
socket = null
socketModel = null

LogAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'

  maxMissedHeartbeats: 4 # how many heartbeats may be missed before erroring?

  heartbeatInterval: Ember.computed ->
    intervalString = config.APP.wsHeartbeatInterval?.toString()
    parseInt(intervalString, 10) * 1000

  urlForQuery: (query, modelName) ->
    api = query.api
    proxyEndpoint = query.proxy_endpoint
    job = query.job
    timer = query.timer
    apiAdapter = Ember.getOwner(@).lookup 'adapter:application'
    proxyEndpointAdapter = Ember.getOwner(@).lookup 'adapter:proxy-endpoint'
    jobAdapter = Ember.getOwner(@).lookup 'adapter:job'
    timerAdapter = Ember.getOwner(@).lookup 'adapter:timer'
    firstPart = apiAdapter.buildURL(api.constructor.modelName, api.id, api._createSnapshot()) if api
    firstPart = proxyEndpointAdapter.buildURL(proxyEndpoint.constructor.modelName, proxyEndpoint.id, proxyEndpoint._createSnapshot()) if proxyEndpoint
    firstPart = jobAdapter.buildURL(job.constructor.modelName, job.id, job._createSnapshot()) if job
    firstPart = timerAdapter.buildURL(timer.constructor.modelName, timer.id, timer._createSnapshot()) if timer
    delete query.api
    delete query.proxy_endpoint
    delete query.job
    delete query.timer
    if firstPart
      url = "#{firstPart}/logs"
    else
      url = @_super arguments...
    url

  buildSocketURL: (type, id, snapshot, query={}) ->
    url = @urlForQuery query, type
    isSecure = (location.protocol is 'https:') or (url.match /^https:\/\//)
    url = url.replace location.host, ''
    url = url.replace config.api.host, ''
    host = config.api.logs.host or config.api.host or location.host
    url = "#{host}#{url}"
    url = url.replace /https?\:\/{2}/g, ''
    url = url.replace /^[a-z]*:\/\//, ''
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}/socket"
    url = @cleanURL url
    url

  enableStreaming: (model) ->
    snapshot = model._createSnapshot()
    query =
      api: model.get 'api'
      proxy_endpoint: model.get 'proxy_endpoint'
      job: model.get 'job'
      timer: model.get 'timer'
    url = @buildSocketURL 'log', model.id, snapshot, query
    @prepareModelForStreaming model
    @openSocket url

  disableStreaming: -> @closeSocket()

  prepareModelForStreaming: (model) ->
    model.set 'body', ''
    socketModel = model

  closeSocket: ->
    #oldSocketUrl = socket?.socket?.url
    if socket?
      #@get('websockets').closeSocketFor oldSocketUrl
      socket?.socket.close()
    @stopHeartbeats(socketModel) if socketModel

  timeoutSocket: ->
    @closeSocket()
    socketModel?.set 'streamingTimeout', true

  openSocket: (url) ->
    @closeSocket()
    newSocket = @get('websockets').socketFor url
    newSocket.on 'message', ((event) ->
      if !@isHeartbeat event.data
        @trigger 'socketMessage', event.data
      else
        @trigger 'socketHeartbeat'
    ), @
    socket = newSocket
    @startHeartbeats(socketModel)

  onSocketMessage: Ember.on 'socketMessage', (data) ->
    model = socketModel
    model.pushLogLine data

  onSocketHeartbeat: Ember.on 'socketHeartbeat', ->
    @resetHeartbeats socketModel

  isHeartbeat: (frame) ->
    frame == 'heartbeat'

  resetHeartbeats: (model) ->
    model.set 'missedHeartbeats', 0

  startHeartbeats: (model) ->
    @resetHeartbeats model
    model.set 'doHeatbeat', true
    @doHeartbeat model

  stopHeartbeats: (model) ->
    model.set 'doHeatbeat', false

  doHeartbeat: (model) ->
    interval = @get 'heartbeatInterval'
    Ember.run.later (=>
      if model.get 'doHeatbeat'
        missed = model.get 'missedHeartbeats'
        maxMissed = @get 'maxMissedHeartbeats'
        model.set 'missedHeartbeats', ++missed
        if missed >= maxMissed
          @timeoutSocket()
        @doHeartbeat model # queue another heartbeat
    ), interval

`export default LogAdapter`
