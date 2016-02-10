`import Ember from 'ember'`
`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  # Generates a unique ID.  Useful for adding temporary client-side IDs to
  # embedded records, many of which may have no ID of their own.
  generateId: -> window.uuid.v4()
  # If the instance didn't come with an ID, it's critical to add one
  # for client-side tracking purposes.
  normalize: (type, hash, property) ->
    hash.id = @generateId() if !hash.id
    @_super.apply @, arguments

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
    serialized = @_super.apply @, arguments
    @serializeId serialized
    delete serialized['api_id']
    serialized
  # Numericize the ID if possible
  serializeId: (serialized) ->
    for key, id of serialized
      if /id$/.test(key.toLowerCase())
        numericId = parseInt id, 10 if id?
        serialized[key] = numericId if id?.toString() == numericId?.toString()
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
