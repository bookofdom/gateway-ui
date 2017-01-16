`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

AccountSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  subscription: Ember.inject.service()

  normalize: (type, hash, property) ->
    hash.card = {}
    delete hash.plan_id if !@get 'subscription.enabled'
    @_super arguments...

`export default AccountSerializer`
