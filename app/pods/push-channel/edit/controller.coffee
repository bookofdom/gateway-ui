`import EditController from 'gateway/pods/edit/controller'`

PushChannelEditController = EditController.extend
  'push': Ember.inject.controller()
  'apis': Ember.computed.alias 'push.apis'

`export default PushChannelEditController`
