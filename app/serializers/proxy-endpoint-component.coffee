`import DS from 'ember-data'`

ProxyEndpointComponentSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    call:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'
  # Serializes transformations by calling each instance's toJSON method.
  serializeHasMany: (record, json, relationship) ->
    if relationship.key == 'before'
      json.before = record.get('before').map (route) -> route.toJSON()
    else if relationship.key == 'after'
      json.after = record.get('after').map (route) -> route.toJSON()
    else
      @_super.apply @, arguments

`export default ProxyEndpointComponentSerializer`
