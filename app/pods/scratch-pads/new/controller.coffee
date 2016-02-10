`import Ember from 'ember'`

ScratchPadsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'scratch-pads': Ember.inject.controller()

  indexModel: Ember.computed.alias 'scratch-pads.model'

`export default ScratchPadsNewController`
