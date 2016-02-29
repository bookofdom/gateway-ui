`import Ember from 'ember'`

ScratchPadsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint': Ember.inject.controller()
  'scratch-pads': Ember.inject.controller()

  endpointType: Ember.computed.alias 'remote-endpoint.model.type'
  indexModel: Ember.computed.alias 'scratch-pads.model'

`export default ScratchPadsNewController`
