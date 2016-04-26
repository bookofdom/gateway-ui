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
    @_super arguments...

`export default JsonSchemaNodeSerializer`
