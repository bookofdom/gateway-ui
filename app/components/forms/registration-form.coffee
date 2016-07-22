`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import Registration from 'gateway/pods/registration/model'`
`import config from 'gateway/config/environment'`

RegistrationFormComponent = BaseFormComponent.extend
  classNames: ['ap-form-login']
  horizontal: false
  stripeService: Ember.inject.service 'stripe'

  modelType: 'registration'

  isSubscriptionEnabled: Ember.computed 'stripeService.enabled', ->
    @get('stripeService.enabled') and
      (config.enablePlanSubscriptions?.toString() is 'true')
  plans: Registration.plans

  isNonZeroPlanAmount: Ember.computed 'isSubscriptionEnabled', 'model.isBillable', ->
    @get('isSubscriptionEnabled') and @get('model.isBillable')

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

  createNewModel: ->
    newModel = @_super arguments...
    newStripeCard = @get('store')?.createRecord 'stripe-card'
    newModel.set 'card', newStripeCard
    newModel

  submit: ->
    model = @get 'model'
    model.save().finally =>
      if !model.get 'errors.messages.length'
        @createNewModel()
        @sendAction 'savedAction'
    false

`export default RegistrationFormComponent`
