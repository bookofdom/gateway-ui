`import Ember from 'ember'`

StatsQueryController = Ember.Controller.extend
  breadCrumb: Ember.computed.alias 'model.name'

`export default StatsQueryController`
