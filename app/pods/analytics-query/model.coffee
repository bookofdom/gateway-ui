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
  executeQuery: ->
    adapter = @container.lookup 'adapter:analytics-query'
    snapshot = @_createSnapshot()
    adapter.executeQuery(snapshot).then (response) =>
      @set 'rawData', response
  rawData: ''
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

  chartData: Ember.computed.parallel.spawn 'rawData', ((rawData) ->
    chartJsTransform resample normalize rawData
  ), null

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
