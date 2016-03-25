defaultScenario = (server) ->
  ###
  Seed your development database using your factories.
  This data will not be loaded in your tests.

  Make sure to define a factory for each model you want to create.
  ###

  # server.createList 'post', 10

  server.loadFixtures 'sessions'

  server.createList 'user', 5
  collections = server.createList 'store_collection', 5
  collections.forEach (collection) ->
    id = collection.id
    server.createList 'store_object', 5, storeCollectionId: id
  apis = server.createList 'api', 5
  apis.forEach (api) ->
    id = api.id
    server.createList 'library', 5, apiId: id

`export default defaultScenario`
