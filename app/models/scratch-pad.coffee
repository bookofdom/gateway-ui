`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from './model'`

ScratchPad = Model.extend
  name: DS.attr 'string'
  code: DS.attr 'string'

  # Relationships
  remote_endpoint_environment_data: DS.belongsTo 'remote-endpoint-environment-datum', async: true

  execute: ->
    adapter = @container.lookup 'adapter:scratch-pad'
    adapter.execute @

`export default ScratchPad`
