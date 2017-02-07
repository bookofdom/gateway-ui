`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

socketModel = null

CustomFunctionBuildAdapter = ApplicationAdapter.extend Ember.Evented,
  websockets: Ember.inject.service 'websockets'

  buildBuildUrl: (model) ->
    snapshot = model._createSnapshot()
    customFunctionSnapshot = snapshot.belongsTo 'custom_function'
    customFunctionAdapter = Ember.getOwner(@).lookup 'adapter:custom-function'
    customFunctionId = customFunctionSnapshot.id
    customFunctionModelName = customFunctionSnapshot.modelName
    customFunctionUrl = customFunctionAdapter.buildURL customFunctionModelName, customFunctionId, customFunctionSnapshot
    url = "#{customFunctionUrl}/build"

    isSecure = (location.protocol is 'https:') or (url.match /^https:\/\//)
    url = url.replace location.host, ''
    url = url.replace config.api.host, ''
    host = config.api.host or location.host
    url = "#{host}#{url}"
    url = url.replace /https?\:\/{2}/g, ''
    url = url.replace /^[a-z]*:\/\//, ''
    protocol = if isSecure then 'wss:' else 'ws:'
    url = "#{protocol}//#{url}"
    url = @cleanURL url
    url

  executeBuild: (model) ->
    url = @buildBuildUrl model
    socketModel = model
    @openSocket url
    model.set 'executing', true

  closeSocket: ->
    url = @buildBuildUrl socketModel
    @get('websockets').closeSocketFor url

  openSocket: (url) ->
    @closeSocket()
    socket = @get('websockets').socketFor url
    socket.on 'message', ((event) ->
      @trigger 'socketMessage', event.data
    ), @

  onSocketMessage: Ember.on 'socketMessage', @, (data) ->
    model = socketModel
    data = JSON.parse(data)
    if data.line?
      model.pushLogLine data.line.line
    else if data.result?
      model.set 'time', data.result.time
      model.set 'executing', false
      @closeSocket()

`export default CustomFunctionBuildAdapter`
