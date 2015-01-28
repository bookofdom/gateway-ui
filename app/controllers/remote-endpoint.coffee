`import Ember from 'ember'`

RemoteEndpointController = Ember.ObjectController.extend
  breadCrumb: Ember.computed 'name', -> @get 'name'

`export default RemoteEndpointController`
