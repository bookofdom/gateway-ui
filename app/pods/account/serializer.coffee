`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`

AccountSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  subscription: Ember.inject.service()

  attrs:
    card:
      serialize: 'records'
      deserialize: 'records'

  normalize: (type, hash, property) ->
    hash.links =
      keys: 'keys'
    hash.card = {}
    delete hash.plan_id if !@get 'subscription.enabled'
    @_super arguments...

`export default AccountSerializer`
