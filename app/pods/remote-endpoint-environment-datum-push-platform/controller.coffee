`import Ember from 'ember'`

RemoteEndpointPushPlatformController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default RemoteEndpointPushPlatformController`
