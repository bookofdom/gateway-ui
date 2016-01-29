`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

PasswordResetConfirmationFormController = FormController.extend
  notify: Ember.inject.service()
  'password/reset-confirmation': Ember.inject.controller()
  modelType: 'password-reset-confirmation'

  token: Ember.computed.alias 'password/reset-confirmation.token'

  'base-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('base')?[0]?.message
  'new-password-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('new_password')?[0]?.message

  createNewModel: ->
    model = @_super.apply @, arguments
    token = @get 'token'
    model.set 'token', token
    model

  actions:
    save: ->
      model = @get 'model'
      model.save().finally =>
        if !model.get 'errors.messages.length'
          successMessage = t 'successes.password-reset-confirmation'
          @createNewModel()
          @transitionToRoute 'login'
          @get('notify').info successMessage

`export default PasswordResetConfirmationFormController`
