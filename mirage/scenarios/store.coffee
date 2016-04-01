storeScenario = (server) ->
  collections = server.createList 'store_collection', 5
  collections.forEach (collection) ->
    id = collection.id
    server.createList 'store_object', 10, storeCollectionId: id

`export default storeScenario`
