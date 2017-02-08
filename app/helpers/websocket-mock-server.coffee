`import Ember from 'ember'`

states =
  connecting: 0
  open: 1
  closing: 2
  closed: 3


WebSocketMock = (url) ->
  @url = url
  @readyState == states.open
  @
  close: ->
    @readyState = states.closed

WebSocketMock.prototype =
  url: null
  readyState: states.connecting


WebSocketMockServer = (serverUrl, onConnect) ->
  @originalWebSocket = window?.WebSocket
  # Override the WebSocket constructor:
  # return a mock web socket instance if the URL matches the server URL,
  # otherwise return an original web socket instance
  window?.WebSocket = (wsUrl) =>
    isRegExp = serverUrl instanceof RegExp
    if (isRegExp and wsUrl.match serverUrl) or (serverUrl == wsUrl)
      @mock = new WebSocketMock wsUrl
      Ember.run.next onConnect, @
      @mock
    else
      new @originalWebSocket wsUrl
  window?.WebSocket.CONNECTING = @originalWebSocket.CONNECTING
  window?.WebSocket.OPEN = @originalWebSocket.OPEN
  window?.WebSocket.CLOSING = @originalWebSocket.CLOSING
  window?.WebSocket.CLOSED = @originalWebSocket.CLOSED
  @

WebSocketMockServer.prototype =
  originalWebSocket: null
  mock: null
  states: states
  open: ->
    @mock.readyState = @states.open
    @mock.onopen? currentTarget: @mock
    @mock.send = (data) => @onReceive data
  onReceive: (data) ->
    # no op (override for use case)
  destroy: ->
    window?.WebSocket = @originalWebSocket
  message: (msg) ->
    if @mock.readyState == states.open
      @mock.onmessage?(
        currentTarget: @mock
        data: msg
      )
  error: ->
    @mock.readyState = @states.closed
    @mock.onerror? currentTarget: @mock
  close: ->
    @mock.readyState = @states.closed
    @mock.onclose? currentTarget: @mock


`export default WebSocketMockServer`
