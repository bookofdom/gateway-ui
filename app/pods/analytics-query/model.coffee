`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`
`import config from 'gateway/config/environment'`

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
      parallel = new Parallel response,
        maxWorkers: 4
        evalPath: config.evalJsUrl
      dependencies = @get 'parallelDependencies'
      parallel.require({name: name, fn: dep}) for name, dep of dependencies
      parallel
        .spawn (rawData) -> chartJsTransform resample normalize rawData
        .then (result) => @set 'chartData', result
  chartData: ''
  parallelDependencies:
    # rootKey is a string inside a string since parallel passes the literal
    # contents of a string rather than a proper quoted string.
    rootKey: '"stats"'
    maxSamples: 100
    # Takes a string and parses it into JSON.
    # Returns an array of data points with timestamp and value attributes.
    normalize: (rawData) ->
      JSON.parse(rawData)?[rootKey]?.map (datum) ->
        timestamp: datum.timestamp
        value: datum.values['response.time']
        'api.id': datum.values['api.id']
        'proxy.id': datum.values['proxy.id']
    # Naively resample by dropping items.
    resample: (data) ->
      (data[i] for i in [0...data.length] by Math.round(data.length / maxSamples))

    # TODO:  almost always prefer map/reduce to `push` for generating arrays
    # TODO:  the series are now hardcoded to api and proxy, but that won't work.
    # Each query type may have different group by's.  Ideally only the selected
    # group by series is computed anyway.  We don't know how many group by's may
    # be avaialble, and thus cannot predict the cost of precomputing all of them.
    # TODO:  don't precompute all series sets ahead of time.  Compute only for
    # the currently selected group by.
    chartJsTransform: (data) ->
      series =
        'all': [
          label: 'All'
          data: []
        ]
        'api.id': {}
        'proxy.id': {}

      data.map (datum) ->
        if datum['api.id']?
          apiID = datum['api.id']
          if !series['api.id'][apiID]? then series['api.id'][apiID] = []
          series['api.id'][apiID].push
            x: new Date(datum.timestamp)
            y: datum.value
        if datum['proxy.id']?
          proxyID = datum['proxy.id']
          if !series['proxy.id'][proxyID]? then series['proxy.id'][proxyID] = []
          series['proxy.id'][proxyID].push
            x: new Date(datum.timestamp)
            y: datum.value

        series.all[0].data.push
          x: new Date(datum.timestamp)
          y: datum.value

      apis = []
      for key, value of series['api.id']
        apis.push
          label: "API #{key}"
          data: value
      series['api.id'] = apis

      proxys = []
      for key, value of series['proxy.id']
        proxys.push
          label: "Proxy Endpoint #{key}"
          data: value
      series['proxy.id'] = proxys

      labelValues = data.map (datum) -> new Date(datum.timestamp)
      min = new Date(Math.min.apply(null, labelValues))
      max = new Date(Math.max.apply(null, labelValues))
      min: min
      max: max
      range: max - min
      series: series
      datasets: series.all

<<<<<<< HEAD
=======
  #chartData: Ember.computed.parallel.spawn 'rawData', ((rawData) ->
  #  chartJsTransform resample normalize rawData
  #), null

>>>>>>> chore-remove-ember-parallel
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
