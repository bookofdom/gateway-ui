`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`
`import { formatDatetime } from 'gateway-ui/helpers/format-datetime'`
`import { timeHelper } from 'gateway-ui/helpers/time-helper'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

  colorblindSafeQualitativePalettes:
    retro: [
      'rgb(204,121,167)'
      'rgb(213,94,0)'
      'rgb(0,114,178)'
      'rgb(240,228,66)'
      'rgb(0,158,115)'
      'rgb(86,180,233)'
      'rgb(230,159,0)'
      'rgb(0,0,0)'
    ]

  chartOptions: Ember.computed 'model.series', ->
    # TODO: smarter label formatting
    ###
    chartData = @get 'model.series'
    range = chartData.range
    switch
      when 0 < range < timeHelper.minutes(2) then labelFormat = 'LTS'# seconds
      when timeHelper.minutes(2) <= range < timeHelper.hours(2) then labelFormat = 'LTS' # minutes
      when timeHelper.hours(2) <= range < timeHelper.days(2) then labelFormat = 'lll' # hours
      when timeHelper.days(2) <= range < timeHelper.weeks(2) then labelFormat = 'll' # days
      when timeHelper.weeks(2) <= range < timeHelper.months(2) then labelFormat = 'll' # weeks
      when timeHelper.months(2) <= range < timeHelper.years(2) then labelFormat = 'll' # months
      else labelFormat = 'lll' # years
    ###
    labelFormat = 'll'
    chart:
      useInteractiveGuideline: true
      margin:
        left: 50
        right: 50
        bottom: 50
    xAxis:
      #rotateLabels: 25
      tickFormat: (d) -> moment(d).format labelFormat

  series: Ember.computed 'model.series', ->
    series = @get 'model.series'
    palette = @get 'colorblindSafeQualitativePalettes.retro'
    series.map (series, i) ->
      series.color = palette[i % palette.length]
      series

`export default AnalyticsQueryController`
