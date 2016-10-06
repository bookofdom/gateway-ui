`import Ember from 'ember'`
`import DS from 'ember-data'`

StatsQuerySerializer = DS.RESTSerializer.extend
  normalizeResponse: (store, primaryModelClass, payload, id, requestType) ->
    payload = stats_queries: payload
    @_super store, primaryModelClass, payload, id, requestType
  normalize: (type, hash, property) ->
    hash.type = hash.id
    @_super arguments...

`export default StatsQuerySerializer`
