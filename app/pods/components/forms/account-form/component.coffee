`import Ember from 'ember'`
`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`
`import Registration from 'gateway/pods/registration/model'`

AccountFormComponent = BaseFormComponent.extend
  subscription: Ember.inject.service()

  modelType: 'account'
  plans: null

  horizontal: false
  savedAction: null
  'show-delete': false

  cc_required: Ember.computed 'model.hasChangedBelongsTo', 'model.plan.isBillable', ->
    @get('model.hasChangedBelongsTo') and @get('model.plan.isBillable')

  'option-groups': Ember.computed ->
    plan: Registration.plans

  fields: [
    name: 'name'
    label: false
    required: true
  ]

`export default AccountFormComponent`
