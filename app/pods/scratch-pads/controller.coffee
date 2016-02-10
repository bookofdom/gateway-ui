`import Ember from 'ember'`

ScratchPadsController = Ember.Controller.extend
  breadCrumb: 'resources.scratch_pad_plural'

  'remote-endpoint-environment-data': Ember.inject.controller()

`export default ScratchPadsController`
