`import Ember from 'ember'`

AnalyticsQueryIndexController = Ember.Controller.extend
  'analytics-query': Ember.inject.controller()

  chartOptions: Ember.computed.alias 'analytics-query.chartOptions'
  model: Ember.computed.alias 'analytics-query.model'

`export default AnalyticsQueryIndexController`
