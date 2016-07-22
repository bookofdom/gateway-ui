`import ApplicationSerializer from 'gateway/serializers/application'`

AccountSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    card:
      serialize: 'records'
      deserialize: false

`export default AccountSerializer`
