`import DS from 'ember-data'`

JsonSchemaNodeSerializer = DS.JSONSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    parent:
      serialize: false
    children:
      embedded: 'always'

  normalize: (typeClass, hash) ->
    hash.parent ?= null
    hash.children ?= []
    @_super arguments...

  serialize: (snapshot, options) ->
    serialized =  @_super arguments...
    console.log 'snapshot', snapshot
    # switch serialized.type
      # when ""
    # console.log serialized

  serializeNode: () ->





  # serialize: (snapshot, options) ->
  #   serialized =  @_super arguments...
  #   if !snapshot.belongsTo('parent')
  #     serialized.patternProperties = {}
  #     serialized.properties = {}
  #     serialized.required = []
  #     snapshot.hasMany('children').forEach (child)  =>
  #       hash = @serializeChild(child)
  #       name = hash.name
  #       delete hash.name
  #       if hash.required then serialized.required.push(name) and delete hash.required
  #       group = if hash.patternName then 'patternProperties'  else 'properties'
  #       serialized[group][name] = hash
  #   delete serialized.children
  #   for key, value of serialized
  #     delete serialized[key] if value is null or value is false
  #   serialized
  #
  # serializeChild: (snapshot) ->
  #   hash = {}
  #   attrs = snapshot.attributes()
  #   for key, value of attrs
  #     hash[key] = value unless value is undefined or value is false
  #   if attrs.type is 'array' && snapshot.hasMany('children')
  #     items = snapshot.hasMany('children')[0].attributes()
  #     hash.items = {}
  #     for key, value of items
  #       hash.items[key] = value unless value is undefined or value is false
  #   hash

`export default JsonSchemaNodeSerializer`
