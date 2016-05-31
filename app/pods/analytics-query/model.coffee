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
  parallelDependencies:
    # rootKey is a string inside a string since parallel passes the literal
    # contents of a string rather than a proper quoted string.
    rootKey: '"stats"'
    maxSamples: 50
    # Takes a string and parses it into JSON.
    # Returns an array of data points with timestamp and value attributes.
    normalize: (rawData) ->
      JSON.parse(rawData)?[rootKey]?.map (datum) ->
        timestamp: datum.timestamp
        value: datum.values['response.time']
    # Naively resample by dropping items.
    resample: (data) ->
      (data[i] for i in [0...data.length] by Math.round(data.length / maxSamples))
    chartJsTransform: (data) ->
      labels: data.map (datum) -> datum.timestamp
      datasets: [
        lineTension: 0.3
        backgroundColor: 'rgba(75,192,192,0.1)'
        borderColor: 'rgba(75,192,192,1)'
        borderCapStyle: 'butt'
        borderDash: []
        borderDashOffset: 0.0
        borderJoinStyle: 'miter'
        pointBorderColor: 'rgba(75,192,192,1)'
        pointBackgroundColor: '#fff'
        pointBorderWidth: 1
        pointHoverRadius: 5
        pointHoverBackgroundColor: 'rgba(75,192,192,1)'
        pointHoverBorderColor: 'rgba(220,220,220,1)'
        pointHoverBorderWidth: 2
        pointRadius: 1
        pointHitRadius: 10
        label: 'Dataset'
        data: data.map (datum) -> datum.value
      ]

  chartOptions:
    scales:
      xAxes: [
        ticks:
          fontSize: 14
        scaleLabel:
          display: true
          fontSize: 14
      ]
      yAxes: [
        ticks:
          fontSize: 14
      ]

  labeledChartData: Ember.computed 'chartData', ->
    chartData = @get('chartData')
    if chartData isnt null
      dates = chartData.labels.map (timestamp) -> new Date(timestamp)
      minDate = new Date(Math.min.apply(null, dates))
      maxDate = new Date(Math.max.apply(null, dates))
      dateRange = maxDate - minDate # in milliseconds
      @chartOptions.scales.xAxes[0].scaleLabel.labelString = "#{moment(minDate).format('lll')} - #{moment(maxDate).format('lll')}"
      second = 1000
      minute = second * 60
      hour = minute * 60
      day = hour * 24
      week = day * 7
      month = week * 4
      year = month * 12
      switch
        when 0 < dateRange < (minute * 2) then tickUnit = 'seconds' # use seconds if you have < 2 minutes (1 - 120)
        when (minute * 2) <= dateRange < (hour * 2) then tickUnit = 'minutes' # use minutes if you have < 2 hours (2 - 120)
        when (hour * 2) <= dateRange < (day * 2) then tickUnit = 'hours' # use hours if you have < 2 days (2 - 48)
        when (day * 2) <= dateRange < (week * 2) then tickUnit = 'days' # use days if you have < 2 weeks (2 - 14)
        when (week * 2) <= dateRange < (month * 2) then tickUnit = 'weeks' # use weeks if you have < 2 months (2 - 8/9)
        when (month * 2) <= dateRange < (year * 2) then tickUnit = 'months' # use months if you have < 2 years (2 - 24)
        else tickUnit = 'years'
      labels = chartData?.labels?.map (label) ->
        switch tickUnit
          when 'seconds' then formattedLabel = moment(label).format('LTS')
          when 'minutes' then formattedLabel = moment(label).format('LTS')
          when 'hours' then formattedLabel = moment(label).format('lll')
          when 'days' then formattedLabel = moment(label).format('ll')
          when 'weeks' then formattedLabel = moment(label).format('ll')
          when 'months' then formattedLabel = moment(label).format('ll')
          when 'years' then formattedLabel = moment(label).format('ll')
          else formattedLabel = moment(label).format('lll')
        formattedLabel
      chartData?.labels = labels
    chartData

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
