`import Ember from 'ember'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'
  queryParams: ['start', 'end']

  'analytics-queries': Ember.inject.controller()

  queries: Ember.computed.alias 'analytics-queries.model'

`export default AnalyticsQueryController`
