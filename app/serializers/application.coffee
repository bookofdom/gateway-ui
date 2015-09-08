`import Ember from 'ember'`
`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  payloadKeyFromModelName: (modelName) ->
    Ember.String.underscore modelName
  keyForRelationship: (rawKey, kind) ->
    key = Ember.String.decamelize rawKey
    singularKey = Ember.String.singularize key
    switch kind
      when 'belongsTo' then "#{key}_id"
      when 'hasMany' then "#{singularKey}_ids"
      else key
  serializeIntoHash: (data, type, snapshot, options) ->
    root = @payloadKeyFromModelName type.modelName
    serialized = @serialize snapshot, options
    # "api_id" field is always transient
    delete serialized['api_id']
    data[root] = serialized
  serializeBelongsTo: (snapshot, json, relationship) ->
    key = relationship.key
    if @_canSerialize key
      belongsTo = Ember.get snapshot, key
      # if provided, use the mapping provided by `attrs` in
      # the serializer
      payloadKey = @_getMappedKey key
      if (payloadKey == key) and @keyForRelationship
        payloadKey = @keyForRelationship key, 'belongsTo'
      # Need to check whether the id is there for new&async records
      if Ember.isNone(belongsTo) || Ember.isNone Ember.get(belongsTo, 'id')
        json[payloadKey] = null
      else
        # prefer data.id value since it is uncast
        # "id" will be a string, which is unacceptable to the server
        value = Ember.get(belongsTo, 'data.id') or Ember.get(belongsTo, 'id')
        json[payloadKey] = value
      if relationship.options.polymorphic
        @serializePolymorphicType snapshot, json, relationship

  # Generates a unique ID.  Useful for adding temporary client-side IDs to
  # embedded records, many of which may have no ID of their own.
  generateId: -> window.uuid.v4()

`export default ApplicationSerializer`
