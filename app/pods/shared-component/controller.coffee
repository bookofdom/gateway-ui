`import Ember from 'ember'`

SharedComponentController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default SharedComponentController`
