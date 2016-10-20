`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`

TimerSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    next = new Date(hash.next * 1000)
    hash.next = next.toISOString()

    try
      hash.parameters = vkbeautify.json JSON.stringify(hash.parameters)
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    next = new Date(snapshot.attributes().next)
    serialized.next = Math.floor(next.getTime() / 1000)

    parameters = snapshot.attributes().parameters
    try
      parameters = JSON.parse parameters if parameters
    catch e
      serialized.dataError = true
    serialized.parameters = parameters
    serialized

`export default TimerSerializer`
