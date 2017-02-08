`import WebSocketMockServer from 'gateway-ui/helpers/websocket-mock-server'`
`import config from  'gateway-ui/config/environment'`


# Mock REPL server simply `eval()`s input and outputs the results.

MockReplInitializer =
  name: 'mock-repl'

  getHeartbeatInterval: ->
    intervalString = config.APP.wsHeartbeatInterval?.toString()
    parseInt(intervalString, 10) * 1000

  # TODO
  # buildSocketURL and cleanURL are duplicate methods found in the repl-session
  # and application adapters.  It's unclear how to lookup an adapter from within
  # an initializer.
  #
  # Ideally, we'd just lookup the repl-session adapter and call buildSocketURL.
  buildSocketURL: ->
    url = "#{config.api.url}/apis/\\d*/environments/\\d*/repl/socket"
    isSecure = (location.protocol is 'https:') or (url.match /^https:\/\//)
    url = url.replace /^[a-z]*:\/\//, '' # remove protocol
    url = "#{location.host}#{url}" if !config.api.host
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}"
    # replace double leading slash with single
    url = @cleanURL url
    url
  cleanURL: (url) ->
    leadingProtocol = /^(http|ws)s?\:\/{2}/
    multiSlashes = /\/{2,}/g
    # if this is a relative path (because no host was specified),
    # then add an initial slash to make the path absolute
    url = "/#{url}" if !url.match leadingProtocol
    # if protocol is included,
    hasProtocol = url.match leadingProtocol
    if hasProtocol
      protocol = hasProtocol[0]
      remaining = url.replace(protocol, '').replace multiSlashes, '/'
    else
      protocol = ''
      remaining = url.replace multiSlashes, '/'
    url = "#{protocol}#{remaining}"
    url

  initialize: (app) ->
    if app.mockRepl
      url = @buildSocketURL()
      heartbeatInterval = @getHeartbeatInterval()
      new WebSocketMockServer new RegExp(url), (server) ->
        server.open()
        setInterval (->
          Ember.run.next ->
            server.message '{"type": "heartbeat"}'
        ), heartbeatInterval
        server.onReceive = (data) ->
          try
            type = 'output'
            output = window?.eval data
          catch error
            type = 'error'
            output = error
          server.message JSON.stringify
            type: type
            data: "#{output}"

`export default MockReplInitializer`
