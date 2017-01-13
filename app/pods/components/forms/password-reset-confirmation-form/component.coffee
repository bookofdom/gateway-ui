`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

PasswordResetConfirmationFormComponent = BaseFormComponent.extend
  classNames: ['ap-form-login']
  horizontal: false
  
  modelType: 'password-reset-confirmation'
  token: null

  'base-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('base')?[0]?.message
  'new-password-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('new_password')?[0]?.message

  createNewModel: ->
    model = @_super arguments...
    token = @get 'token'
    model.set 'token', token
    model

  submit: ->
    model = @get 'model'
    model.save().finally =>
      if !model.get 'errors.messages.length'
        @createNewModel()
        @sendAction 'savedAction'
    false

`export default PasswordResetConfirmationFormComponent`
