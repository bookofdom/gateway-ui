`import EditController from 'gateway/controllers/edit'`

JobEditController = EditController.extend
  'jobs': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'jobs.option-groups'

`export default JobEditController`
