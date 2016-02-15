`import Ember from 'ember'`

ApiController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'
  breadCrumbSecondary: Ember.computed 'model.base_url', -> @get 'model.base_url'

`export default ApiController`
