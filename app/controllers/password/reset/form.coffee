`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

PasswordResetFormController = FormController.extend
  notify: Ember.inject.service()
  modelType: 'password-reset'

  'base-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('base')?[0]?.message
  'email-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('email')?[0]?.message

  actions:
    save: ->
      model = @get 'model'
      model.save().finally =>
        if !model.get 'errors.messages.length'
          successMessage = t 'successes.password-reset-confirmation'
          @transitionToRoute 'login'
          @get('notify').info successMessage

`export default PasswordResetFormController`
