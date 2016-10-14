`import Ember from 'ember'`

TimerIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'timer.edit'

`export default TimerIndexRoute`
