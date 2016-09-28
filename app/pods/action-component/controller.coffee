`import Ember from 'ember'`

ActionComponentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ActionComponentController`
