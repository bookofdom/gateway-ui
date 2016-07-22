`import ApplicationAdapter from 'gateway/adapters/application'`

RegistrationAdapter = ApplicationAdapter.extend
  stripeService: Ember.inject.service 'stripe'
  ajax: (url, type, options) ->
    outerSuper = @_super
    outerSelf = @
    outerArgs = arguments
    stripeService = @get 'stripeService'
    card = options?.data?.registration?.card
    delete options?.data?.registration?.card
    if card.validationError
      Ember.RSVP.reject new DS.InvalidError [
        detail: card.validationError.message
        source:
          pointer: '/data'
          #pointer: "/relationships/card/data/attributes/#{card.validationError.field}"
      ]
    else if card and !card.validationError
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
            options?.data?.registration?.stripe_card_token = response.id
            outerSuper.apply(outerSelf, outerArgs)
              .then (response) -> resolve response
              .catch (response) -> reject response
    else
      @_super arguments...

`export default RegistrationAdapter`
