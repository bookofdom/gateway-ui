`import storeScenario from 'gateway/mirage/scenarios/store'`
`import userScenario from 'gateway/mirage/scenarios/user'`

defaultScenario = (server) ->
  # sessions
  server.loadFixtures 'sessions'

  # logs
  server.createList 'log', 1

  # users
  userScenario server

  # store collections and store objects
  storeScenario server

  # APIs and api-related
  apis = server.createList 'api', 5
  apis.forEach (api) ->
    id = api.id
    server.createList 'environment', 3, apiId: id
    server.createList 'library', 5, apiId: id
    server.createList 'host', 5, apiId: id
    server.createList 'endpoint_group', 5, apiId: id
    server.createList('remote_endpoint', 20, apiId: id).forEach (remoteEndpoint) ->
      options =
        remoteEndpointId: remoteEndpoint.id
        type: remoteEndpoint.type
      server.createList('remote_endpoint_environment_datum', 3, options).forEach (datum) ->
        server.createList 'scratch_pad', 2,
          remoteEndpointEnvironmentDatumId: datum.id
    server.createList 'shared_component', 10, apiId: id
    server.createList('proxy_endpoint', 50, apiId: id).forEach (proxyEndpoint) ->
      server.createList 'proxy_endpoint_component', 10,
        proxyEndpointId: proxyEndpoint.id

`export default defaultScenario`
