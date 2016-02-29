`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from './model'`

ScratchPad = Model.extend
  name: DS.attr 'string'
  code: DS.attr 'string'

  # Relationships
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: true

  execute: ->
    adapter = @container.lookup 'adapter:scratch-pad'
    adapter.execute @

`export default ScratchPad`
