`import Ember from 'ember'`

ScratchPadsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint': Ember.inject.controller()
  'scratch-pads': Ember.inject.controller()

  endpointModel: Ember.computed.alias 'remote-endpoint.model'
  indexModel: Ember.computed.alias 'scratch-pads.model'

`export default ScratchPadsNewController`
