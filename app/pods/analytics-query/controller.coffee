`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`
`import { formatDatetime } from 'gateway/helpers/format-datetime'`
`import { timeHelper } from 'gateway/helpers/time-helper'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

  colorblindSafeQualitativeColors: [
    'rgb(204,121,167)' # pink mauve
    'rgb(213,94,0)' # bittersweet
    'rgb(0,114,178)' # blue
    'rgb(240,228,66)' # yellow
    'rgb(0,158,115)' # dark seafoam green
    'rgb(86,180,233)' # cyan
    'rgb(230,159,0)' # orange
    'rgb(0,0,0)' # black
  ]

  chartOptions: Ember.computed 'model.series', ->
    # TODO: this
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
    {}

  series: Ember.computed 'model.series', ->
    series = @get 'model.series'
    palette = @get 'colorblindSafeQualitativeColors'
    series.map (series, i) ->
      series.color = palette[i % palette.length]
      series

`export default AnalyticsQueryController`
