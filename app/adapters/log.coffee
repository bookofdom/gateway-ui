`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

LogAdapter = ApplicationAdapter.extend
  websockets: Ember.inject.service 'websockets'

  # Only one log socket allowed in app.  That socket is kept here.
  socket: null

  buildSocketURL: (type, id, snapshot) ->
    url = @buildURL type, id, snapshot
    url = url.replace 'http://', ''
    url = "#{location.host}#{url}" if !config.api.host
    "ws://#{url}/socket"

  enableStreaming: (record) ->
    snapshot = record._createSnapshot()
    url = @buildSocketURL 'log', record.id, snapshot
    @openSocket url

  closeSocket: ->
    oldSocketUrl = @get 'socket.socket.url'
    @get('websockets').closeSocketFor oldSocketUrl if oldSocketUrl

  openSocket: (url) ->
    @closeSocket()
    socket = @get('websockets').socketFor url
    @set 'socket', socket

`export default LogAdapter`
