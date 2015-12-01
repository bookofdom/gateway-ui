`import FormController from 'gateway/controllers/form'`
`import t from 'gateway/helpers/i18n'`

RegistrationFormController = FormController.extend
  notify: Ember.inject.service()
  modelType: 'registration'

  'base-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('base')?[0]?.message
  'email-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('email')?[0]?.message
  'password-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('password')?[0]?.message
  'password-confirmation-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('password_confirmation')?[0]?.message
  'organization-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('organization')?[0]?.message

  actions:
    save: ->
      model = @get 'model'
      model.save().finally =>
        if !model.get 'errors.messages.length'
          successMessage = t 'successes.sign-up'
          @createNewModel()
          @transitionToRoute 'login'
          @get('notify').info successMessage

`export default RegistrationFormController`
