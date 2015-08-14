`import Ember from 'ember'`
`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  keyForRelationship: (rawKey, kind) ->
    key = Ember.String.decamelize rawKey
    singularKey = Ember.String.singularize key
    switch kind
      when 'belongsTo' then "#{key}_id"
      when 'hasMany' then "#{singularKey}_ids"
      else key
  serializeIntoHash: (data, type, record, options) ->
    root = Ember.String.decamelize type.modelName
    serialized = @serialize record, options
    # "api_id" field is always transient
    delete serialized['api_id']
    data[root] = serialized
  serializeBelongsTo: (record, json, relationship) ->
    key = relationship.key
    if @_canSerialize key
      belongsTo = Ember.get record, key
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
        @serializePolymorphicType record, json, relationship

`export default ApplicationSerializer`
