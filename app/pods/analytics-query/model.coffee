`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

AnalyticsQuery = Model.extend
  type: DS.attr 'string', defaultValue: 'response-time'

  # Computed
  typeKind: Ember.computed 'type', ->
    type = @get 'type'
    AnalyticsQuery.types.findBy 'value', type
  name: Ember.computed.alias 'typeKind.name'

# Declare available types and their human-readable names
types = 'response-time'.split(' ').map (type) ->
  name: t "types.analytics-query.#{type}"
  slug: type
  value: type

AnalyticsQuery.reopenClass
  types: types
  # High-level analytics queries exist only client-side.
  # They are hardcoded here.
  FIXTURES: [
    id: 1
    type: 'response-time'
  ,
    id: 2
    type: 'response-time'
  ]

`export default AnalyticsQuery`
