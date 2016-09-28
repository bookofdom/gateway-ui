`import ActionComponentCallsIndexController from 'gateway/pods/action-component-calls/index/controller'`

JobComponentCallsIndexController = ActionComponentCallsIndexController.extend
  prefix: 'job'
  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

`export default JobComponentCallsIndexController`
