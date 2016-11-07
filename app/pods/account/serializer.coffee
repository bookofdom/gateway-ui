`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`
`import StripeCardSerializerMixin from 'gateway/mixins/stripe-card-serializer'`

AccountSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin, StripeCardSerializerMixin,
  subscription: Ember.inject.service()

  attrs:
    card:
      serialize: false
      deserialize: 'records'

  normalize: (type, hash, property) ->
    hash.card = {}
    delete hash.plan_id if !@get 'subscription.enabled'
    @_super arguments...

`export default AccountSerializer`
