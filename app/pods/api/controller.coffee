`import Ember from 'ember'`

ApiController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default ApiController`
