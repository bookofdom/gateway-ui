`import BaseFormComponent from 'gateway/components/forms/base-form'`

PasswordResetFormComponent = BaseFormComponent.extend
  classNames: ['ap-form-login']
  horizontal: false
  
  modelType: 'password-reset'

  'base-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('base')?[0]?.message
  'email-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('email')?[0]?.message

  submit: ->
    model = @get 'model'
    model.save().finally =>
      if !model.get 'errors.messages.length'
        @createNewModel()
        @sendAction 'savedAction'
    false

`export default PasswordResetFormComponent`
