`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`
`import t from 'gateway/helpers/i18n'`

RegistrationSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    card:
      serialize: 'records'
      deserialize: false

`export default RegistrationSerializer`
