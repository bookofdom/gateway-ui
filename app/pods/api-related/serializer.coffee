`import ApplicationSerializer from 'gateway/pods/application/serializer'`

ApiRelatedSerializer = ApplicationSerializer.extend
  serialize: ->
    serialized = @_super arguments...
    delete serialized['api_id']
    serialized

`export default ApiRelatedSerializer`
