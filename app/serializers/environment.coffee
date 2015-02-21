`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

variableIdCounter = 1

EnvironmentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    variables:
      #embedded: 'always'
      serialize: false
      deserialize: 'records'
  normalize: (type, hash, property) ->
    @normalizeVariables hash
    @_super.apply @, arguments
  normalizeVariables: (hash) ->
    # `data` is reserved in Ember, so transform into `variables`
    # adds ephemeral IDs to generated variable records
    hash.data ?= {}
    hash.variables = []
    for key, value of hash.data
      hash.variables.push
        id: variableIdCounter++
        name: key
        value: value
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data = @serializeVariables model
    serialized
  serializeVariables: (model) ->
    hash = {}
    model.get('variables').forEach (variable) ->
      hash[variable.get 'name'] = variable.get 'value'
    hash

`export default EnvironmentSerializer`
