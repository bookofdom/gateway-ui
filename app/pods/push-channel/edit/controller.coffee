`import EditController from 'gateway/controllers/edit'`

PushChannelEditController = EditController.extend
  'push': Ember.inject.controller()
  'apis': Ember.computed.alias 'push.model.apis'

`export default PushChannelEditController`
