`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

# Only one log socket allowed in app.  That socket is kept here.
# Record updating is handled by the adapter, so the record is stored here.
# These are kept outside of the adapter class since adapters are disposable.
socket = null
socketRecord = null

LogAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'

  isSecure: Ember.computed -> location.protocol is 'https:'

  urlForQuery: (query, modelName) ->
    api = query.api
    proxyEndpoint = query.proxy_endpoint
    apiAdapter = @container.lookup 'adapter:application'
    proxyEndpointAdapter = @container.lookup 'adapter:proxy-endpoint'
    firstPart = apiAdapter.buildURL(api.constructor.modelName, api.id, api._createSnapshot()) if api
    firstPart = proxyEndpointAdapter.buildURL(proxyEndpoint.constructor.modelName, proxyEndpoint.id, proxyEndpoint._createSnapshot()) if proxyEndpoint
    delete query.api
    delete query.proxy_endpoint
    if firstPart
      url = "#{firstPart}/logs"
    else
      url = @_super.apply @, arguments
    url

  buildSocketURL: (type, id, snapshot, query={}) ->
    url = @urlForQuery query, type
    url = url.replace location.host, ''
    url = url.replace config.api.host, ''
    host = config.api.logs.host or config.api.host or location.host
    url = "#{host}#{url}"
    url = url.replace /https?\:\/{2}/g, ''
    isSecure = @get 'isSecure'
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}/socket"
    url = @cleanURL url
    url

  enableStreaming: (record) ->
    snapshot = record._createSnapshot()
    query =
      api: record.get 'api'
      proxy_endpoint: record.get 'proxy_endpoint'
    url = @buildSocketURL 'log', record.id, snapshot, query
    @prepareRecordForStreaming record
    @openSocket url

  disableStreaming: -> @closeSocket()

  prepareRecordForStreaming: (record) ->
    record.set 'body', ''
    socketRecord = record

  closeSocket: ->
    oldSocketUrl = socket?.socket?.url
    if oldSocketUrl
      @get('websockets').closeSocketFor oldSocketUrl

  openSocket: (url) ->
    @closeSocket()
    newSocket = @get('websockets').socketFor url
    newSocket.on 'message', ((event) -> @trigger 'socketMessage', event.data), @
    socket = newSocket

  onSocketMessage: Ember.on 'socketMessage', (data) ->
    record = socketRecord
    record.pushLogLine data

`export default LogAdapter`
