`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

RegistrationActivationRoute = Ember.Route.extend
  notify: Ember.inject.service()
  redirectAfterRoute: 'login'
  queryParams:
    token:
      refreshModel: false

  model: (params) ->
    if params.token
      @store.createRecord 'registration-activation', token: params.token
  afterModel: ->
    model = @modelFor 'registration.activation'
    if model
      @notifyActivation()
    else
      @transitionTo @get('redirectAfterRoute')

  notifyActivation: ->
    successMessage = t 'successes.registration-activation'
    @transitionTo @get('redirectAfterRoute')
    @get('notify').info successMessage

`export default RegistrationActivationRoute`
