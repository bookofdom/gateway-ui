`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

# Only one log socket allowed in app.  That socket is kept here.
# Record updating is handled by the adapter, so the record is stored here.
socket = null
socketRecord = null

LogAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'

  buildSocketURL: (type, id, snapshot) ->
    url = @buildURL type, id, snapshot
    url = url.replace 'http://', ''
    url = "#{location.host}#{url}" if !config.api.host
    "ws://#{url}/socket"

  enableStreaming: (record) ->
    snapshot = record._createSnapshot()
    url = @buildSocketURL 'log', record.id, snapshot
    @prepareRecordForStreaming record
    @openSocket url

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
