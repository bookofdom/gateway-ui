`import DS from 'ember-data'`

JsonNodeSerializer = DS.JSONSerializer.extend DS.EmbeddedRecordsMixin,
  normalizedIdCounter: 0

  attrs:
    parent:
      serialize: false
    children:
      serialize: false
      deserialize: 'records'

  getNormalizedId: ->
    id = @get('normalizedIdCounter') + 1
    @set 'normalizedIdCounter', id

  normalizeNode: (nodePayload) ->
    nodeType = typeof nodePayload
    hash = switch nodeType
      when 'string', 'number', 'boolean'
        type: nodeType
        value: nodePayload
      when 'object'
        if Ember.isNone nodePayload
          type: 'null'
        else if Ember.isArray nodePayload
          type: 'array'
          children: (@normalizeNode(value) for value in nodePayload)
        else
          type: 'object'
          children: for key, value of nodePayload
            Ember.merge @normalizeNode(value),
              name: key
    defaultHash =
      id: @getNormalizedId()
    Ember.merge hash, defaultHash

  normalizeArrayResponse: (store, primaryModelClass, payload, id, requestType) ->
    normalized = [@normalizeNode payload]
    val = @_super.apply @, [store, primaryModelClass, normalized, id, requestType]
    val

  serialize: (snapshot, options) ->
    serialized =  @_super arguments...

`export default JsonNodeSerializer`
