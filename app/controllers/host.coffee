`import Ember from 'ember'`

HostController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default HostController`
