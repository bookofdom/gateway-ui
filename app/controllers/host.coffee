`import Ember from 'ember'`

HostController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default HostController`
