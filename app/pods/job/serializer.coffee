`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway/pods/api-related/serializer'`

JobSerializer = ApiRelatedSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: false
    components:
      embedded: 'always'
    tests:
      serialize: false
  normalize: (type, hash, property) ->
    hash.components = [] if !hash.components
    @normalizeLinks hash
    @_super arguments...
  # Adds links to async relationships.
  normalizeLinks: (hash) ->
    hash.links =
      tests: "/apis/#{hash.api_id}/jobs/#{hash.id}/tests"
    hash

`export default JobSerializer`
