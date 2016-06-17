`import Ember from 'ember'`

AnalyticsQueryIndexController = Ember.Controller.extend
  'analytics-query': Ember.inject.controller()

  chartOptions: Ember.computed.alias 'analytics-query.chartOptions'
  series: Ember.computed.alias 'analytics-query.series'

`export default AnalyticsQueryIndexController`
