`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

routeIdCounter = 1

ProxyEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    routes:
      embedded: 'always'
    components:
      embedded: 'always'
    tests:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeLinks hash
    @normalizeRoutes hash
    @normalizeComponentCallLinks hash
    @_super.apply @, arguments
  # Adds links to async relationships.
  normalizeLinks: (hash) ->
    hash.links =
      environment:
        "/apis/#{hash.api_id}/environments/#{hash.environment_id}" if hash.environment_id
      endpoint_group:
        "/apis/#{hash.api_id}/endpoint_groups/#{hash.endpoint_group_id}" if hash.endpoint_group_id
    hash
  # Adds ephemeral IDs to embedded route records, since IDs are required.
  normalizeRoutes: (hash) ->
    hash.routes ?= []
    for route in hash.routes
      route.id = routeIdCounter++
    hash
  # Adds links to embedded component calls
  normalizeComponentCallLinks: (hash) ->
    if hash.components
      for component in hash.components
        if component.call?.remote_endpoint_id
          component.call.links =
            remote_endpoint: "/apis/#{hash.api_id}/remote_endpoints/#{component.call.remote_endpoint_id}"
        if component.calls
          for call in component.calls
            if call.remote_endpoint_id
              call.links =
                remote_endpoint: "/apis/#{hash.api_id}/remote_endpoints/#{call.remote_endpoint_id}"
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized.endpoint_group_id = parseInt(serialized.endpoint_group_id, 10) if serialized.endpoint_group_id?
    serialized.environment_id = parseInt(serialized.environment_id, 10) if serialized.environment_id?
    serialized

`export default ProxyEndpointSerializer`
