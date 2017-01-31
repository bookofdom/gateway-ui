`import Ember from 'ember'`
`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  # Generates a unique ID.  Useful for adding temporary client-side IDs to
  # embedded records, many of which may have no ID of their own.
  generateId: -> window.uuid.v4()
  normalize: (type, hash, property) ->
    hash.id = @generateId() if !hash.id
    @_super arguments...
  # Ensure that response has a body if it's not a delete request.
  # `normalize` is called only for responses with bodies and normalize adds the
  # Ember-required ID if one is not present.
  # However, `delete` requests with a body and an ID will fail miserably, so
  # we check to make sure this is not a delete request.
  # Since 2.10, responses are required to have an ID.
  normalizeSingleResponse: (store, primaryModelClass, payload, id, requestType) ->
    if !requestType.match /delete/
      payloadKey = @payloadKeyFromModelName primaryModelClass.modelName
      if payload? and !payload[payloadKey]
        payload[payloadKey] = {}
    @_normalizeResponse store, primaryModelClass, payload, id, requestType, true

  payloadKeyFromModelName: (modelName) ->
    Ember.String.underscore modelName
  keyForRelationship: (rawKey, kind) ->
    key = Ember.String.decamelize rawKey
    singularKey = Ember.String.singularize key
    switch kind
      when 'belongsTo' then "#{key}_id"
      when 'hasMany' then "#{singularKey}_ids"
      else key

  serialize: ->
    serialized = @_super arguments...
    @serializeId serialized
    serialized
  # Numericize the ID if possible
  serializeId: (serialized) ->
    id = serialized.id
    numericId = parseInt id, 10 if id?
    serialized.id = numericId if id?.toString() == numericId?.toString()
    serialized
  # Server wants IDs to be numeric.
  serializeBelongsTo: (snapshot, json, relationship) ->
    key = relationship.key
    if @_canSerialize key
      belongsToId = snapshot.belongsTo key, id: true
      # if provided, use the mapping provided by `attrs` in
      # the serializer
      payloadKey = @_getMappedKey key, snapshot.type
      if (payloadKey is key) and @keyForRelationship
        payloadKey = @keyForRelationship key, 'belongsTo', 'serialize'
      # Need to check whether the id is there for new&async records
      if Ember.isNone belongsToId
        json[payloadKey] = null
      else
        json[payloadKey] = parseInt belongsToId, 10

`export default ApplicationSerializer`
