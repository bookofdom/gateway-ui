`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import Registration from 'gateway-ui/pods/registration/model'`
`import { brandName } from 'gateway-ui/helpers/brand-name'`
`import config from 'gateway-ui/config/environment'`

RegistrationFormComponent = BaseFormComponent.extend
  classNames: ['ap-form-login']
  horizontal: false
  subscription: Ember.inject.service()
  stripeCheckout: Ember.inject.service()

  modelType: 'registration'
  plans: null
  planName: null

  isNonZeroPlanAmount: Ember.computed 'subscription.enabled', 'model.plan.isBillable', ->
    @get('subscription.enabled') and @get('model.plan.isBillable')

  'base-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('base')?[0]?.message
  'email-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('email')?[0]?.message
  'password-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('password')?[0]?.message or
      @get('password-blank-error')
  'password-confirmation-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('password_confirmation')?[0]?.message or
      @get('password-match-error')
  'organization-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('organization')?[0]?.message

  validatePassword: ->
    model = @get 'model'
    password = @get 'model.password'
    passwordConfirmation = @get 'model.password_confirmation'
    if !password
      model.get('errors').add 'password', 'errors.invalid-password'
      false
    else if password != passwordConfirmation
      model.get('errors').add 'password_confirmation', 'errors.mismatched-passwords'
      false
    else
      true

  submit: ->
    model = @get 'model'
    stripeCheckoutService = @get 'stripeCheckout'
    paymentRequired = @get 'isNonZeroPlanAmount'
    isValid = @validatePassword()
    if isValid
      saveRegistration = (token) =>
        model.set 'stripe_token', token.id if token
        model.save().finally =>
          if !model.get 'errors.messages.length'
            @createNewModel()
            @sendAction 'savedAction'
      if !paymentRequired
        saveRegistration()
      else
        checkout = stripeCheckoutService.getToken
          name: brandName 'primary'
          description: model.get 'plan.name'
          zipCode: true
          email: model.get 'email'
          amount: model.get 'plan.price'
        checkout.then saveRegistration
    false

`export default RegistrationFormComponent`
