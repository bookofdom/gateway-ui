`import Ember from 'ember'`
`import { formatDatetime } from 'gateway/helpers/format-datetime'`
`import { timeHelper } from 'gateway/helpers/time-helper'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

  chartOptions: Ember.computed 'model.chartData', ->
    chartData = @get 'model.chartData'
    scales:
      xAxes: [
        ticks:
          fontSize: 14
        scaleLabel:
          display: true
          fontSize: 14
          labelString: "#{formatDatetime(chartData.min)} - #{formatDatetime(chartData.max)}"
      ]
      yAxes: [
        ticks:
          fontSize: 14
      ]

  labeledChartData: Ember.computed 'model.chartData', ->
    chartData = @get 'model.chartData'
    if chartData?
      range = chartData.range
      switch
        when 0 < range < timeHelper.minutes(2) then labelFormat = 'LTS'# seconds
        when timeHelper.minutes(2) <= range < timeHelper.hours(2) then labelFormat = 'LTS' # minutes
        when timeHelper.hours(2) <= range < timeHelper.days(2) then labelFormat = 'lll' # hours
        when timeHelper.days(2) <= range < timeHelper.weeks(2) then labelFormat = 'll' # days
        when timeHelper.weeks(2) <= range < timeHelper.months(2) then labelFormat = 'll' # weeks
        when timeHelper.months(2) <= range < timeHelper.years(2) then labelFormat = 'll' # months
        else labelFormat = 'lll' # years
      labels = chartData?.labels?.map (label) ->
        moment(label).format(labelFormat)
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
