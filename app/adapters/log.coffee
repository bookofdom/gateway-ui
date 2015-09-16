`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

LogAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'

  # Only one log socket allowed in app.  That socket is kept here.
  # Record updating is handled by the adapter, so the record is stored here.
  socket: null
  socketRecord: null

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
    @set 'socketRecord', record

  closeSocket: ->
    oldSocketUrl = @get 'socket.socket.url'
    @get('websockets').closeSocketFor oldSocketUrl if oldSocketUrl

  openSocket: (url) ->
    @closeSocket()
    socket = @get('websockets').socketFor url
    socket.on 'message', ((event) -> @trigger 'socketMessage', event.data), @
    @set 'socket', socket

  onSocketMessage: Ember.on 'socketMessage', (data) ->
    record = @get 'socketRecord'
    record.pushLogLine data

`export default LogAdapter`
