`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.name', -> @get 'model.name'

`export default RemoteEndpointEnvironmentDatumScratchPadController`
