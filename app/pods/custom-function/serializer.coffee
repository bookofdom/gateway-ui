`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway-ui/pods/api-related/serializer'`

CustomFunctionSerializer = ApiRelatedSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: false
    tests:
      serialize: false
  normalize: (type, hash, property) ->
    @normalizeLinks hash
    @_super arguments...
  # Adds links to async relationships.
  normalizeLinks: (hash) ->
    hash.links =
      files: "/apis/#{hash.api_id}/custom_functions/#{hash.id}/files"
      tests: "/apis/#{hash.api_id}/custom_functions/#{hash.id}/tests"
    hash

`export default CustomFunctionSerializer`
