`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`
`import { formatDatetime } from 'gateway/helpers/format-datetime'`
`import { timeHelper } from 'gateway/helpers/time-helper'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

  groupBy: 'all'

  availableGroupBy: Ember.String.w('all api proxy')

  actions:
    selectGroupBy: (groupBy) ->
      labeledChartData = @get('labeledChartData')
      if groupBy is 'api'
        labeledChartData.datasets = labeledChartData.series['api.id']
      else if groupBy is 'proxy'
        labeledChartData.datasets = labeledChartData.series['proxy.id']
      else
        labeledChartData.datasets = labeledChartData.series.all
      labeledChartData = @decorateChartData(labeledChartData)
      @set 'labeledChartData', labeledChartData

  decorateChartData: (chartData) ->
    chartData?.datasets.map (dataset) ->
      hue = Math.floor(Math.random() * 360)
      foregroundColor = 'hsl(' + hue + ", 100%, 87.5%)";
      backgroundColor = 'hsla(' + hue + ", 100%, 87.5%, .5)";
      Ember.merge dataset,
        lineTension: 0.3
        backgroundColor: backgroundColor
        borderColor: foregroundColor
        borderCapStyle: 'butt'
        borderDash: []
        borderDashOffset: 0.0
        borderJoinStyle: 'miter'
        pointBorderColor: foregroundColor
        pointBackgroundColor: '#fff'
        pointBorderWidth: 1
        pointHoverRadius: 5
        pointHoverBackgroundColor: foregroundColor
        pointHoverBorderColor: 'rgba(220,220,220,1)'
        pointHoverBorderWidth: 2
        pointRadius: 1
        pointHitRadius: 10
    chartData

  chartOptions: Ember.computed 'model.chartData', ->
    chartData = @get 'model.chartData'
    range = chartData.range
    switch
      when 0 < range < timeHelper.minutes(2) then labelFormat = 'LTS'# seconds
      when timeHelper.minutes(2) <= range < timeHelper.hours(2) then labelFormat = 'LTS' # minutes
      when timeHelper.hours(2) <= range < timeHelper.days(2) then labelFormat = 'lll' # hours
      when timeHelper.days(2) <= range < timeHelper.weeks(2) then labelFormat = 'll' # days
      when timeHelper.weeks(2) <= range < timeHelper.months(2) then labelFormat = 'll' # weeks
      when timeHelper.months(2) <= range < timeHelper.years(2) then labelFormat = 'll' # months
      else labelFormat = 'lll' # years

    # TODO: This only formats the label properly if using moment directly and not a helper
    xAxisLabel = "#{moment(chartData.min).format('lll')} - #{moment(chartData.max).format('lll')}"

    scales:
      xAxes: [
        type: 'time'
        time:
          displayFormats:
            quarter: labelFormat
        ticks:
          fontSize: 14
        scaleLabel:
          display: true
          fontSize: 14
          labelString: xAxisLabel
      ]
      yAxes: [
        ticks:
          fontSize: 14
      ]

  labeledChartData: Ember.computed 'model.chartData', ->
    chartData = @get 'model.chartData'
    # adds presentational attributes
    if chartData?
      chartData = @decorateChartData(chartData)
    chartData

`export default AnalyticsQueryController`
