`import EditController from 'gateway-ui/pods/edit/controller'`

JobEditController = EditController.extend
  'jobs': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'jobs.option-groups'

`export default JobEditController`
