`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

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
      json = JSON.parse parameters if parameters
    serialized.parameters = json
    serialized

`export default TimerSerializer`
