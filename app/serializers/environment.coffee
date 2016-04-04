`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

EnvironmentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: false
    variables:
      serialize: false
      deserialize: 'records'
  normalize: (type, hash, property) ->
    hash.variables = [] if !hash.variables
    @normalizeVariables hash
    @_super arguments...
  normalizeVariables: (hash) ->
    # `data` is reserved in Ember, so transform into `variables`
    hash.data ?= {}
    hash.variables = []
    for key, value of hash.data
      hash.variables.push
        name: key
        value: value
    console.log hash
    hash
  serialize: (snapshot) ->
    serialized = @_super arguments...
    serialized.data = @serializeVariables snapshot
    serialized
  serializeVariables: (snapshot) ->
    hash = {}
    snapshot.hasMany('variables').forEach (variableSnapshot) ->
      attributes = variableSnapshot.attributes()
      hash[attributes.name] = attributes.value
    hash

`export default EnvironmentSerializer`
