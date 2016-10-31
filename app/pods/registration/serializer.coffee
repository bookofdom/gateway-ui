`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`
`import StripeCardSerializerMixin from 'gateway/mixins/stripe-card-serializer'`
`import t from 'gateway/helpers/i18n'`

RegistrationSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin, StripeCardSerializerMixin,
  attrs:
    card:
      serialize: false
      deserialize: false

`export default RegistrationSerializer`
