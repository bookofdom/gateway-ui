`import Ember from 'ember'`

ScratchPadsIndexController = Ember.Controller.extend
  'scratch-pads': Ember.inject.controller()

  'remote-endpoint': Ember.inject.controller()

  endpointType: Ember.computed.alias 'remote-endpoint.model.type'
  indexModel: Ember.computed.alias 'scratch-pads.model'

`export default ScratchPadsIndexController`
