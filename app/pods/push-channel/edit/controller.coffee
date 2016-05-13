`import EditController from 'gateway/controllers/edit'`

PushChannelEditController = EditController.extend
  'manage': Ember.inject.controller()
  'apis': Ember.computed.alias 'manage.model.apis'

`export default PushChannelEditController`
