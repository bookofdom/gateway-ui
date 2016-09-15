`import EditController from 'gateway/controllers/edit'`

TimerEditController = EditController.extend
  'timers': Ember.inject.controller()
  'apis': Ember.computed.alias 'timers.apis'

`export default TimerEditController`
