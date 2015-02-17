`import Ember from 'ember'`

EndpointGroupController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default EndpointGroupController`
