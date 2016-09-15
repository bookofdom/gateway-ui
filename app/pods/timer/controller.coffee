`import Ember from 'ember'`

TimerController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default TimerController`
