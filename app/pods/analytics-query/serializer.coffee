`import Ember from 'ember'`
`import DS from 'ember-data'`

AnalyticsQuerySerializer = DS.RESTSerializer.extend
  normalizeResponse: (store, primaryModelClass, payload, id, requestType) ->
    payload = analytics_queries: payload
    @_super store, primaryModelClass, payload, id, requestType

`export default AnalyticsQuerySerializer`
