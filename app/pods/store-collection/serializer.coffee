`import ApplicationSerializer from 'gateway/serializers/application'`

StoreCollectionSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      store_objects: 'store_objects'
    @_super arguments...

`export default StoreCollectionSerializer`
