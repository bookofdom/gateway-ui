`import ApplicationSerializer from 'gateway/serializers/application'`

AccountSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  subscription: Ember.inject.service()

  attrs:
    card:
      serialize: 'records'
      deserialize: 'records'

  normalize: (type, hash, property) ->
    hash.card = {}
    delete hash.plan_id if !@get 'subscription.enabled'
    @_super arguments...

`export default AccountSerializer`
