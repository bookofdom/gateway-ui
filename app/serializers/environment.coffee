`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

EnvironmentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    variables:
      serialize: false
      deserialize: 'records'
  normalize: (type, hash, property) ->
    @normalizeVariables hash
    @_super.apply @, arguments
  normalizeVariables: (hash) ->
    # `data` is reserved in Ember, so transform into `variables`
    hash.data ?= {}
    hash.variables = []
    for key, value of hash.data
      hash.variables.push
        name: key
        value: value
    hash
  serialize: (snapshot) ->
    serialized = @_super.apply @, arguments
    serialized.data = @serializeVariables snapshot
    serialized
  serializeVariables: (snapshot) ->
    hash = {}
    snapshot.hasMany('variables').forEach (variableSnapshot) ->
      attributes = variableSnapshot.attributes()
      hash[attributes.name] = attributes.value
    hash

`export default EnvironmentSerializer`
