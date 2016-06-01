`import Ember from 'ember'`

AnalyticsQueryIndexController = Ember.Controller.extend
  'analytics-query': Ember.inject.controller()

  chartOptions: Ember.computed.alias 'analytics-query.chartOptions'
  labeledChartData: Ember.computed.alias 'analytics-query.labeledChartData'

`export default AnalyticsQueryIndexController`
