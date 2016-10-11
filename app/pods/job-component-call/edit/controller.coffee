`import EditController from 'gateway/pods/edit/controller'`

JobComponentCallEditController = EditController.extend
  'job-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'job-component-calls.indexModel'
  'option-groups': Ember.computed.alias 'job-component-calls.option-groups'

  'transformation-option-groups': Ember.computed.alias 'job-component-calls.transformation-option-groups'

`export default JobComponentCallEditController`
