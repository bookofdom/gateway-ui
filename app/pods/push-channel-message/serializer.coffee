`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`

PushChannelMessageSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    stamp = new Date(hash.stamp * 1000)
    hash.stamp = stamp.toISOString()
    try hash.body = vkbeautify.json JSON.stringify(hash.data)
    @_super arguments...

`export default PushChannelMessageSerializer`
