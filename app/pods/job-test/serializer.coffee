`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

JobTestSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    try
      hash.parameters = vkbeautify.json JSON.stringify(hash.parameters)
    @_super arguments...

  serialize: (snapshot) ->
    serialized = @_super arguments...

    parameters = snapshot.attributes().parameters
    try
      json = JSON.parse parameters if parameters
    serialized.parameters = json
    serialized

`export default JobTestSerializer`
