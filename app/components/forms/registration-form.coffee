`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import Registration from 'gateway/pods/registration/model'`
`import config from 'gateway/config/environment'`

RegistrationFormComponent = BaseFormComponent.extend
  modelType: 'registration'

  isPlanSubscriptionEnabled: config.enablePlanSubscriptions?.toString() is 'true'
  plans: Registration.plans

  isNonZeroPlanAmount: Ember.computed 'isPlanSubscriptionEnabled', 'model.isBillable', ->
    @get('isPlanSubscriptionEnabled') and @get('model.isBillable')

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

  'cc-number-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('cc_number')?[0]?.message
  'cc-expiry-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('cc_exp_year')?[0]?.message
  'cc-cvc-error': Ember.computed 'model.errors.[]', ->
    @get('model.errors')?.errorsFor('cc_cvc')?[0]?.message

  submit: ->
    model = @get 'model'
    model.save().finally =>
      if !model.get 'errors.messages.length'
        @createNewModel()
        @sendAction 'savedAction'
    false

`export default RegistrationFormComponent`
