`import Ember from 'ember'`

# TODO
# Every map, min, and max call performed here is blocking.
# See TODOs below.

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

  # TODO:  this should be computed and include the axis title(s)
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

  labeledChartData: Ember.computed 'model.chartData', ->
    chartData = @get 'model.chartData'
    if chartData?
      # TODO:  precompute integer values for dates in worker in a separate
      # property.  `labelValues` perhaps?
      dates = chartData.labels.map (timestamp) -> new Date(timestamp)
      # TODO:  precompute min, max, and range in worker.
      minDate = new Date(Math.min.apply(null, dates))
      maxDate = new Date(Math.max.apply(null, dates))
      dateRange = maxDate - minDate # in milliseconds
      # TODO:  use helpers instead of calling moment directly.  This may require
      # adding additional helpers.  It should be trivial to swap the underlaying
      # date formatting library.
      @chartOptions.scales.xAxes[0].scaleLabel.labelString =
        "#{moment(minDate).format('lll')} - #{moment(maxDate).format('lll')}"
      # TODO:  time definitions may make sense in a helper where they may be
      # reused as needed.
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
      # TODO:  This map operation must occur outside of a worker because it
      # relies on moment.  However, it is inefficient because each step has a
      # conditional.  Since the conditional is not label-dependent, invert this
      # so that the conditional happens first and only once, then the map step.
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
    # adds presentational attributes
    chartData?.datasets.map (dataset) ->
      Ember.merge dataset,
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
    chartData

`export default AnalyticsQueryController`
