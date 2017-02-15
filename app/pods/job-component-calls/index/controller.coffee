`import Ember from 'ember'`

JobComponentCallsIndexController = Ember.Controller.extend
  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

`export default JobComponentCallsIndexController`
