`import Ember from 'ember'`

TimersIndexController = Ember.Controller.extend
  'timers': Ember.inject.controller()
  'apis': Ember.computed.alias 'timers.apis'

`export default TimersIndexController`
