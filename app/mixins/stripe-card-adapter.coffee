`import Ember from 'ember'`
`import DS from 'ember-data'`

# Mixin for adapters that need to send a stripe token to the
# server, such as account and registration.
#
# Resources that need to send stripe tokens must have a `stripe_token`
# property on their model, i.e.:
#
#     stripe_token: DS.attr 'string'
#
# And their serializers must use the `StripeCardSerializerMixin` mixin.
#
# Overrides methods `updateRecord` and `createRecord` to append a
# stripe token to the body of the request.


# This method is used to override both createRecord and updateRecord in adapter.
injectStripeTokenMethod = (store, type, snapshot) ->
  # Gather stripe card data
  card = snapshot.belongsTo('card').record.serialize()
  cardFilled = card.number

  if cardFilled
    # Get a stripe token promise because card was filled.
    outerSuper = @_super
    outerSelf = @
    outerArgs = arguments
    new Ember.RSVP.Promise (resolve, reject) =>
      @stripeTokenPromise card

        # Yay!  We got a stripe token.  Lets add it to the payload and
        # execute the original promise.
        .then (stripeToken) ->
          # TODO yeah, you're not supposed to do this but...
          snapshot._attributes.stripe_token = stripeToken
          outerSuper.apply(outerSelf, outerArgs)
            .then (response) -> resolve response
            .catch (response) -> reject response

        # Reject because card was bad.
        .catch (err) -> reject err
  else
    # No stripe card, so just proceed with default behavior.
    @_super arguments...


StripeCardAdapterMixin = Ember.Mixin.create
  stripeService: Ember.inject.service 'stripe'

  # Returns a promise that either A) resolves with a stripe token or B)
  # rejects with a DS.InvalidError
  stripeTokenPromise: (card) ->
    if card.validationError
      Ember.RSVP.reject new DS.InvalidError [
        detail: card.validationError.message
        source:
          pointer: '/data'
          #pointer: "/relationships/card/data/attributes/#{card.validationError.field}"
      ]
    else
      stripeService = @get 'stripeService'
      new Ember.RSVP.Promise (resolve, reject) ->
        stripeService.createCardToken card, (status, response) ->
          if response.error
            reject new DS.InvalidError [
              detail: response.error.message
              source:
                pointer: '/data'
                #pointer: "/data/relationships/card/data/attributes/#{response.error.param}"
            ]
          else
            resolve response.id

  createRecord: injectStripeTokenMethod
  updateRecord: injectStripeTokenMethod

`export default StripeCardAdapterMixin`
