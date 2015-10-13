`import Ember from 'ember'`
`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  # For each entry in `attrs` where `assignTransientIds` is `true`, assign a
  # transient ID to each child of the array in the format `parentId_index`.
  normalizeTransientIdHasManyFields: (hash) ->
    attrs = @get 'attrs'
    transientIdsFieldNames =
      ((key if value.assignTransientIds) for key, value of attrs).compact()
    transientIdsFieldNames.forEach (fieldName) =>
      @assignTransientIdsToEach hash, fieldName
  assignTransientIdsToEach: (hash, fieldName) ->
    id = hash.id
    items = hash[fieldName]
    items?.forEach (item, i) -> item.id = "#{id}_#{i}"
  normalize: (type, hash, property) ->
    @normalizeTransientIdHasManyFields hash
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
  # Request payload is rooted.
  serialize: ->
    serialized = @_super.apply @, arguments
    delete serialized['api_id']
    serialized
  # Server wants IDs to be numeric.
  serializeBelongsTo: (snapshot, json, relationship) ->
    key = relationship.key
    if @_canSerialize key
      belongsToId = snapshot.belongsTo key, id: true
      # if provided, use the mapping provided by `attrs` in
      # the serializer
      payloadKey = @_getMappedKey key
      if (payloadKey is key) and @keyForRelationship
        payloadKey = @keyForRelationship key, 'belongsTo', 'serialize'
      # Need to check whether the id is there for new&async records
      if Ember.isNone belongsToId
        json[payloadKey] = null
      else
        json[payloadKey] = parseInt belongsToId, 10

`export default ApplicationSerializer`
