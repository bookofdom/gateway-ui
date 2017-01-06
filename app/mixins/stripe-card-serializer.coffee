`import Ember from 'ember'`
`import DS from 'ember-data'`

StripeCardSerializerMixin = Ember.Mixin.create
  normalize: (type, hash, property) ->
    hash.stripe_token = null
    @_super arguments...

  serialize: ->
    serialized = @_super arguments...
    delete serialized.stripe_token if !serialized.stripe_token
    serialized

`export default StripeCardSerializerMixin`
