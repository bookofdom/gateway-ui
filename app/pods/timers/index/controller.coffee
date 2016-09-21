`import Ember from 'ember'`

TimersIndexController = Ember.Controller.extend
  'timers': Ember.inject.controller()
  'apis': Ember.computed.alias 'timers.apis'

  actions:
    'logs-timer': (timer) ->
      @transitionToRoute 'logs-timer', timer

`export default TimersIndexController`
