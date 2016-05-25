`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

AnalyticsQuery = Model.extend
  type: DS.attr 'string', defaultValue: 'response-time'
  default_query: DS.attr()
  start: DS.attr 'string'
  end: DS.attr 'string'

  # Computed
  typeKind: Ember.computed 'type', ->
    type = @get 'type'
    AnalyticsQuery.types.findBy 'value', type
  name: Ember.computed.alias 'typeKind.name'
  queryParams: Ember.computed 'default_query', 'start', 'end', ->
    query =
      start: @get 'start'
      end: @get 'end'
    Ember.merge query, @get('default_query')

  # Computed Query Results
  rawData: Ember.computed.promise 'queryParams', (->
    adapter = @container.lookup 'adapter:analytics-query'
    snapshot = @_createSnapshot()
    adapter.executeQuery snapshot
  ), ''

# Declare available types and their human-readable names
types = 'response-time placeholder-1 placeholder-2'.split(' ').map (type) ->
  name: t "types.analytics-query.#{type}"
  slug: type
  value: type

AnalyticsQuery.reopenClass
  types: types
  # High-level analytics queries exist only client-side.
  # They are hardcoded here.
  FIXTURES: [
    id: 'response-time'
    default_query:
      variable: 'response.time'
  ,
    id: 'placeholder-1'
    default_query:
      variable: 'placeholder.variable.1'
  ,
    id: 'placeholder-2'
    default_query:
      variable: 'placeholder.variable.2'
  ]

`export default AnalyticsQuery`
