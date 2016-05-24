`import Ember from 'ember'`

AnalyticsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

`export default AnalyticsQueryController`
