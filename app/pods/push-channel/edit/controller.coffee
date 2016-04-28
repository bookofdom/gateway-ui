`import EditController from 'gateway/controllers/edit'`

PushChannelEditController = EditController.extend
  'push-channels': Ember.inject.controller()
  'api': Ember.computed.alias 'push-channels.api'

`export default PushChannelEditController`
