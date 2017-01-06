`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`
`import config from 'gateway-ui/config/environment'`

AnalyticsQuery = Model.extend
  type: DS.attr 'string', defaultValue: 'response-time'
  default_query: DS.attr()
  available_group_by: DS.attr()
  start: DS.attr 'string'
  end: DS.attr 'string'
  group_by: DS.attr 'string'

  # Computed
  typeKind: Ember.computed 'type', ->
    type = @get 'type'
    AnalyticsQuery.types.findBy 'value', type
  name: Ember.computed.alias 'typeKind.name'
  groupByKind: Ember.computed 'group_by', ->
    groupBy = @get 'group_by'
    AnalyticsQuery.groupBys.findBy 'value', groupBy
  groupByName: Ember.computed.alias 'groupByKind.name'
  queryParams: Ember.computed 'default_query', 'start', 'end', ->
    query =
      start: @get 'start'
      end: @get 'end'
    Ember.merge query, @get('default_query')
  availableGroupByKinds: Ember.computed 'available_group_by', ->
    @get('available_group_by').map (value) ->
      AnalyticsQuery.groupBys.findBy 'value', value

  # Computed Query Results
  executeQuery: ->
    adapter = @container.lookup 'adapter:analytics-query'
    snapshot = @_createSnapshot()
    adapter.executeQuery(snapshot).then (response) =>
      @set 'rawData', response
  rawData: null
  series: []
  dataObserver: Ember.observer 'rawData', 'group_by', ->
    data =
      data: @get 'rawData'
      groupBy: @get 'group_by'
    parallel = new Parallel data,
      maxWorkers: 4
      evalPath: config.evalJsUrl
    dependencies = @get 'parallelDependencies'
    parallel.require({name: name, fn: dep}) for name, dep of dependencies
    parallel
      .spawn (data) -> seriesTransform groupBy resample normalize data
      .then (result) => @set 'series', result
  parallelDependencies:
    # rootKey is a string inside a string since parallel passes the literal
    # contents of a string rather than a proper quoted string.
    rootKey: '"stats"'
    maxSamples: 500
    # Takes a string and parses it into JSON.
    # Returns an array of data points with timestamp and value attributes.
    normalize: (data) ->
      groupBy: data.groupBy
      data: JSON.parse(data.data)?[rootKey]?.map (datum) ->
        value =
          timestamp: datum.timestamp
          value: datum.values['response.time']
        value[data.groupBy] = datum.values[data.groupBy] if data.groupBy
        value
    # Naively resample by dropping items.
    # TODO:  resample should happen after group-by and should occur within
    # each series
    resample: (data) ->
      if data.data.length > maxSamples
        data.data = (data.data[i] for i in [0...data.data.length] by Math.round(data.data.length / maxSamples))
      data
    # Group by selected value
    groupBy: (data) ->
      data.groups = {}
      if data.groupBy
        data.data.forEach (item) ->
          value = item[data.groupBy]
          if value
            group = data.groups[value] ?= []
            group.push item
      data
    seriesTransform: (data) ->
      if data.groupBy
        for name, values of data.groups
          key: name
          values: values.map (value) ->
            x: new Date(value.timestamp)
            y: value.value
      else
        [
          key: 'All'
          values: data.data.map (value) ->
            x: new Date(value.timestamp)
            y: value.value
        ]

# Declare available types and their human-readable names
types = 'response-time placeholder-1 placeholder-2'.split(' ').map (type) ->
  name: t "types.analytics-query.#{type}"
  slug: type
  value: type

groupBys = 'api remote-endpoint proxy-endpoint'.split(' ').map (type) ->
  name: t "resources.#{type}"
  slug: type
  value: "#{type.replace('-endpoint', '')}.id"

AnalyticsQuery.reopenClass
  types: types
  groupBys: groupBys
  # High-level analytics queries exist only client-side.
  # They are hardcoded here.
  FIXTURES: [
    id: 'response-time'
    default_query:
      variable: 'response.time'
    available_group_by: [
      'api.id'
      'proxy.id'
    ]
  ,
    id: 'placeholder-1'
    default_query:
      variable: 'placeholder.variable.1'
    available_group_by: [
      'remote.id'
      'proxy.id'
    ]
  ,
    id: 'placeholder-2'
    default_query:
      variable: 'placeholder.variable.2'
    available_group_by: [
      'api.id'
      'remote.id'
      'proxy.id'
    ]
  ]

`export default AnalyticsQuery`
