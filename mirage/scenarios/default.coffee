defaultScenario = (server) ->
  # sessions
  server.loadFixtures 'sessions'

  # plans
  server.createList 'plan', 3

  # accounts
  server.createList 'account', 1, planId: Math.round(Math.random() * 2) + 1

  # account keys
  server.createList 'key', 5

  # logs
  server.createList 'log', 1

  # timers
  server.createList 'timer', 5

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
    server.createList('remote_endpoint', 32, apiId: id).forEach (remoteEndpoint) ->
      options =
        apiId: id
        remoteEndpointId: remoteEndpoint.id
        type: remoteEndpoint.type
      server.createList('remote_endpoint_environment_datum', 3, options).forEach (datum) ->
        server.createList 'scratch_pad', 2,
          remoteEndpointEnvironmentDatumId: datum.id
    server.createList 'shared_component', 10, apiId: id
    server.createList('proxy_endpoint', 50, apiId: id).forEach (proxyEndpoint) ->
      server.createList 'proxy_endpoint_component', 10,
        proxyEndpointId: proxyEndpoint.id
      server.createList 'proxy_endpoint_schema', 5,
        proxyEndpointId: proxyEndpoint.id
    server.createList('job', 50, apiId: id).forEach (job) ->
      server.createList 'job_component', 10,
        jobId: job.id

  # push
  channels = server.createList 'push_channel', 5
  channels.forEach (channel) ->
    id = channel.id
    channelMessages = server.createList 'push_channel_message', 1, pushChannelId: id
    devices = server.createList 'push_device', 5, pushChannelId: id
    devices.forEach (device) ->
      id = device.id
      server.createList 'push_message', 5, pushDeviceId: id

`export default defaultScenario`
