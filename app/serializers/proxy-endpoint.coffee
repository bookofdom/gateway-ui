`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway/serializers/api-related'`

ProxyEndpointSerializer = ApiRelatedSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: false
    routes:
      embedded: 'always'
    components:
      embedded: 'always'
    tests:
      embedded: 'always'
    schemas:
      serialize: false
  normalize: (type, hash, property) ->
    hash.routes = [] if !hash.routes
    hash.components = [] if !hash.components
    hash.tests = [] if !hash.tests
    @normalizeLinks hash
    @_super arguments...
  # Adds links to async relationships.
  normalizeLinks: (hash) ->
    hash.links =
      schemas: "/apis/#{hash.api_id}/proxy_endpoints/#{hash.id}/schemas"
    hash

`export default ProxyEndpointSerializer`
