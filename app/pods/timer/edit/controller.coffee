`import EditController from 'gateway-ui/pods/edit/controller'`

TimerEditController = EditController.extend
  'timers': Ember.inject.controller()
  'apis': Ember.computed.alias 'timers.apis'

`export default TimerEditController`
