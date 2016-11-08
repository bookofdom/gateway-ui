`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

RegistrationConfirmationRoute = Ember.Route.extend
  notify: Ember.inject.service()
  redirectAfterRoute: 'login'
  queryParams:
    token:
      refreshModel: false

  model: (params) ->
    if params.token
      @store.createRecord 'registration-confirmation', token: params.token
  afterModel: ->
    model = @modelFor 'registration.confirmation'
    if model
      model.save().then => @notifyConfirmation()
    else
      @transitionTo @get('redirectAfterRoute')

  notifyConfirmation: ->
    successMessage = t 'successes.registration-confirmation'
    @transitionTo @get('redirectAfterRoute')
    @get('notify').info successMessage

`export default RegistrationConfirmationRoute`
