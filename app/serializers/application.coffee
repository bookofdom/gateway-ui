`import DS from 'ember-data'`

ApplicationSerializer = DS.RESTSerializer.extend
  serializeIntoHash: (data, type, record, options) ->
    root = Ember.String.decamelize type.typeKey
    serialized = @serialize record, options
    delete serialized['api_id'] # this field is always transient
    data[root] = serialized
  keyForRelationship: (rawKey, kind) ->
    key = Ember.String.decamelize rawKey
    singularKey = Ember.String.singularize key
    switch kind
      when 'belongsTo' then "#{key}_id"
      when 'hasMany' then "#{singularKey}_ids"
      else key

`export default ApplicationSerializer`
