defaultScenario = (server) ->
  # sessions
  server.loadFixtures 'sessions'

  # logs
  server.createList 'log', 1

  # users
  server.createList 'user', 5

  # store collections and store objects
  collections = server.createList 'store_collection', 5
  collections.forEach (collection) ->
    id = collection.id
    server.createList 'store_object', 10, storeCollectionId: id

  # APIs and api-related
  apis = server.createList 'api', 5
  apis.forEach (api) ->
    id = api.id
    server.createList 'environment', 3, apiId: id
    server.createList 'library', 5, apiId: id
    server.createList 'host', 5, apiId: id
    server.createList 'endpoint_group', 5, apiId: id
    remoteEndpoints = server.createList 'remote_endpoint', 20, apiId: id
    remoteEndpoints.forEach (remoteEndpoint) ->
      data = server.createList 'remote_endpoint_environment_datum', 3,
        remoteEndpointId: remoteEndpoint.id
        type: remoteEndpoint.type
      data.forEach (datum) ->
        server.createList 'scratch_pad', 2,
          remoteEndpointEnvironmentDatumId: datum.id

`export default defaultScenario`
