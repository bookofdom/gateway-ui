`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

LogSerializer = ApplicationSerializer.extend
  _normalizeResponse: (store, primaryModelClass, payload, id, requestType, isSingle) ->
    payload = logs: [payload]
    @_super.apply @, [store, primaryModelClass, payload, id, requestType, isSingle]
  normalize: (type, hash, property) ->
    hash.lines = hash.logs
    @_super.apply @, arguments

`export default LogSerializer`
