`import Ember from 'ember'`

ApiController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default ApiController`
