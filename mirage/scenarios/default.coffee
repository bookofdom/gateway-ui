defaultScenario = (server) ->
  # sessions
  server.loadFixtures 'sessions'

  # users
  server.createList 'user', 5

  # store collections and store objects
  collections = server.createList 'store_collection', 5
  collections.forEach (collection) ->
    id = collection.id
    server.createList 'store_object', 5, storeCollectionId: id

  # APIs and api-related
  apis = server.createList 'api', 5
  apis.forEach (api) ->
    id = api.id
    server.createList 'library', 5, apiId: id
    server.createList 'host', 5, apiId: id

`export default defaultScenario`
