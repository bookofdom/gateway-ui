`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

TimerSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    next = new Date(hash.next * 1000)
    hash.next = next.toISOString()

    try
      hash.attributes = vkbeautify.json JSON.stringify(hash.attributes)
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    next = new Date(snapshot.attributes().next)
    serialized.next = Math.floor(next.getTime() / 1000)

    attributes = snapshot.attributes().attributes
    try
      attributes = JSON.parse attributes if attributes
    catch e
      serialized.dataError = true
    serialized.attributes = attributes
    serialized

`export default TimerSerializer`
