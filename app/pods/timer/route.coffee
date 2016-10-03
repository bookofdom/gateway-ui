`import Ember from 'ember'`

TimerRoute = Ember.Route.extend
  model: (params) -> @modelFor('timers').findBy 'id', params.timer_id
  actions:
    deleted: ->
      @transitionTo 'timers'

`export default TimerRoute`
