`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

routeIdCounter = 1

ProxyEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    routes:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeLinks hash
    @normalizeRoutes hash
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
    for route in hash.routes
      route.id = routeIdCounter++
    hash
  serializeHasMany: (record, json, relationship) ->
    if relationship.key == 'routes'
      json.routes = record.get('routes').map (route) -> route.toJSON()
    else
      @_super.apply @, arguments

`export default ProxyEndpointSerializer`
