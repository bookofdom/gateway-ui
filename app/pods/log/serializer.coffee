`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

LogSerializer = ApplicationSerializer.extend
  normalizeResponse: (store, primaryModelClass, payload, id, requestType) ->
    payload = logs: [payload]
    @_super store, primaryModelClass, payload, id, requestType
  normalize: (type, hash, property) ->
    hash.lines = hash.logs
    @_super arguments...

`export default LogSerializer`
