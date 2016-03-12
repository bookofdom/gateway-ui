`import ApplicationAdapter from 'gateway/adapters/application'`

StoreObjectAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    host = @get 'host'
    url = url.replace host, ''
    collectionId = snapshot?.belongsTo('store_collection').id
    if collectionId
      url = "#{@pathForType('store-collection')}/#{collectionId}/#{url}"
    url = "#{host}/#{url}"
    @cleanURL url

`export default StoreObjectAdapter`
