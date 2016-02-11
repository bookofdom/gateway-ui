`import Ember from 'ember'`

ScratchPadsIndexController = Ember.Controller.extend
  'scratch-pads': Ember.inject.controller()

  indexModel: Ember.computed.alias 'scratch-pads.model'

`export default ScratchPadsIndexController`
