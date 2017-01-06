`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import Registration from 'gateway-ui/pods/registration/model'`
`import config from 'gateway-ui/config/environment'`

RegistrationFormComponent = BaseFormComponent.extend
  classNames: ['ap-form-login']
  horizontal: false
  subscription: Ember.inject.service()

  modelType: 'registration'
  plans: null
  planName: null

  isNonZeroPlanAmount: Ember.computed 'subscription.enabled', 'model.plan.isBillable', ->
    @get('subscription.enabled') and @get('model.plan.isBillable')

  cc_required: Ember.computed.alias 'isNonZeroPlanAmount'

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
