`import ActionComponentCallEditController from 'gateway/pods/action-component-call/edit/controller'`

JobComponentCallEditController = ActionComponentCallEditController.extend
  prefix: 'job'

  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

  'transformation-option-groups': Ember.computed.alias 'job-component-calls.transformation-option-groups'

`export default JobComponentCallEditController`
