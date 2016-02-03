`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: false
    environment:
      serialize: 'id'
    endpoint_group:
      serialize: 'id'
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
    @_super.apply @, arguments
  # Adds links to async relationships.
  normalizeLinks: (hash) ->
    hash.links =
      schemas: "/apis/#{hash.api_id}/proxy_endpoints/#{hash.id}/schemas"
    hash

`export default ProxyEndpointSerializer`
