`import ApplicationSerializer from 'gateway/serializers/application'`

AccountSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    card:
      serialize: 'records'
      deserialize: 'records'

  normalize: (type, hash, property) ->
    hash.card = {}
    @_super arguments...

`export default AccountSerializer`
