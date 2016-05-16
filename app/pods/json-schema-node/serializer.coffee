`import DS from 'ember-data'`

id = 0

JsonSchemaNodeSerializer = DS.JSONSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    proxy_endpoint_schema_request_parent:
      serialize: false
    proxy_endpoint_schema_response_parent:
      serialize: false
    parent:
      serialize: false
    children:
      serialize: false
      deserialize: 'records'

  # All serializable attributes by type.
  attrsByType:
    '*': ['type', 'title', 'description']
    'object': ['properties', 'patternProperties', 'required', 'additionalProperties', 'minProperties', 'maxProperties']
    'array': ['items', 'minItems', 'maxItems', 'uniqueItems']
    'number': ['multipleOf', 'minimum', 'maximum', 'exclusiveMinimum', 'exclusiveMaximum']
    'integer': ['multipleOf', 'minimum', 'maximum', 'exclusiveMinimum', 'exclusiveMaximum']
    'string': ['pattern', 'minLength', 'maxLength']

  normalize: (typeClass, hash) ->
    hash.id = ++id
    hash.parent ?= null
    hash.children ?= []
    hash.requiredAttrs = hash.required
    hash.required = hash.shouldBeRequired
    for key, value of hash.patternProperties
      value.name = key
      value.patternName = true
      if hash.requiredAttrs? and (key in hash.requiredAttrs) then value.shouldBeRequired = true
      hash.children.push value
    for key, value of hash.properties
      value.name = key
      if hash.requiredAttrs? and (key in hash.requiredAttrs) then value.shouldBeRequired = true
      if value.type is 'array'
        value.children ?= []
        if Array.isArray value.items
          for item in value.items
            value.children.push item
        else
          value.children.push value.items
        delete value.items
      hash.children.push value
    delete hash.requiredAttrs
    delete hash.shouldBeRequired
    delete hash.properties
    delete hash.patternProperties
    @_super arguments...

  # JSON Schema attribute keys are camel case.
  keyForAttribute: (attr, method) ->
    Ember.String.camelize attr

  # Returns an object containing only attributes allowed for the type as
  # specified in `attrsByType`.  Non-allowed attributes and attributes with
  # values of `false`, `null`, or `undefined` are thrown out, except
  # `additionalProperties`, which is included only if it is `false`.
  cleanAttributes: (serialized) ->
    cleaned = {}
    allowed = Ember.copy(@get('attrsByType.*')).concat @get("attrsByType.#{serialized.type}")
    allowed.forEach (attrName) ->
      value = serialized[attrName]
      cleaned[attrName] = value if !Ember.isNone(value) and (value != false) and (attrName != 'additionalProperties')
      # Since additionalProperties defaults to `true`, we only include it if
      # it is set to `false`.
      cleaned[attrName] = value if (attrName is 'additionalProperties') and (value is false)
    delete cleaned.required if !Ember.isArray cleaned.required
    cleaned

  serialize: (snapshot, options) ->
    serialized =  @_super arguments...
    children = snapshot.hasMany 'children'
    switch serialized.type
      when 'array'
        # An array node's children go into `items`.
        if children.length == 1
          serialized.items = children[0].serialize()
        else if children.length > 1
          serialized.items = children.map (child) -> child.serialize()
      when 'object'
        # An object node's children go into `properties` or `patternProperties`.
        children.forEach (child) ->
          name = child.attr 'name'
          if child.attr 'pattern_name'
            serialized.patternProperties ?= {}
            serialized.patternProperties[name] = child.serialize()
          else
            serialized.properties ?= {}
            serialized.properties[name] = child.serialize()
        serialized.required = children
          .map (child) -> child.attr('name') if child.attr 'required'
          .compact()
    @cleanAttributes serialized

`export default JsonSchemaNodeSerializer`
