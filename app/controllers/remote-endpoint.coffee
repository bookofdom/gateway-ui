`import Ember from 'ember'`

RemoteEndpointController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default RemoteEndpointController`
