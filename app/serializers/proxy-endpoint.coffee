`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

ProxyEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
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
    # console.log "type #{type}"
    # console.log "hash #{hash}"
    # console.log "property #{property}"
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
