`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`
`import StripeCardSerializerMixin from 'gateway-ui/mixins/stripe-card-serializer'`
`import t from 'gateway-ui/helpers/i18n'`

RegistrationSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin, StripeCardSerializerMixin,
  attrs:
    card:
      serialize: false
      deserialize: false

`export default RegistrationSerializer`
