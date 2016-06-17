`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`
`import { formatDatetime } from 'gateway/helpers/format-datetime'`
`import { timeHelper } from 'gateway/helpers/time-helper'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

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

`export default AnalyticsQueryController`
