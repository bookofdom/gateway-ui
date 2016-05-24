`import Ember from 'ember'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'
  queryParams: ['start', 'end']

`export default AnalyticsQueryController`
