`import EditController from 'gateway/controllers/edit'`

PushChannelEditController = EditController.extend
  'push-channels': Ember.inject.controller()
  'apis': Ember.computed.alias 'push-channels.apis'

`export default PushChannelEditController`
