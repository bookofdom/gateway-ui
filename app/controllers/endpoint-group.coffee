`import Ember from 'ember'`

EndpointGroupController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default EndpointGroupController`
