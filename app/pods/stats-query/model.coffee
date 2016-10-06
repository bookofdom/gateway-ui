`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`
`import t from 'gateway/helpers/i18n'`
`import config from 'gateway/config/environment'`

StatsQuery = Model.extend
  type: DS.attr 'string', defaultValue: 'response-time'
  default_query: DS.attr()
  start: DS.attr 'string'
  end: DS.attr 'string'

  # Computed
  typeKind: Ember.computed 'type', ->
    type = @get 'type'
    StatsQuery.types.findBy 'value', type
  name: Ember.computed.alias 'typeKind.name'

  # Computed Query Results
  executeQuery: ->
    adapter = Ember.getOwner(@).lookup 'adapter:stats-query'
    snapshot = @_createSnapshot()
    adapter.executeQuery(snapshot).then (response) =>
      @set 'rawData', response
  rawData: null
  series: []
  dataObserver: Ember.observer 'rawData', ->
    data = data: @get 'rawData'
    series = @seriesTransform @normalize data
    @set 'series', series
  normalize: (data) ->
    data: JSON.parse(data.data)?.stats?.map (datum) ->
      value =
        timestamp: datum.timestamp
        value: datum.values['response.time']
      value
  seriesTransform: (data) ->
    [
      key: 'All'
      values: data.data.map (value) ->
        x: new Date(value.timestamp)
        y: value.value
    ]

# Declare available types and their human-readable names
types = 'response-time average-speed '.split(' ').map (type) ->
  name: t "types.stats-query.#{type}"
  slug: type
  value: type

StatsQuery.reopenClass
  types: types
  # Prebuilt stats queries exist only client-side.
  # They are hardcoded here.
  FIXTURES: [
    id: 'response-time'
    default_query:
      variable: 'response.time'
  ,
    id: 'average-speed'
    default_query:
      variable: 'average-speed'
  ,
    id: 'placeholder-2'
    default_query:
      variable: 'placeholder.variable.2'
  ]

`export default StatsQuery`
