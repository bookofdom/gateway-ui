`import ApplicationSerializer from 'gateway/serializers/application'`

ApiRelatedSerializer = ApplicationSerializer.extend
  serialize: ->
    serialized = @_super arguments...
    delete serialized['api_id']
    serialized

`export default ApiRelatedSerializer`
