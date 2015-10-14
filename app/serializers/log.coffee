`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

LogSerializer = ApplicationSerializer.extend
  extractArray: (store, typeClass, payload, id, requestType) ->
    payload = logs: [payload]
    @_super.apply @, [store, typeClass, payload, id, requestType]
  normalize: (type, hash, property) ->
    hash.body = hash.logs
    @_super.apply @, arguments

`export default LogSerializer`
