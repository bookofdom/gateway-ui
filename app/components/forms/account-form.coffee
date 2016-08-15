`import Ember from 'ember'`
`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import Registration from 'gateway/pods/registration/model'`

AccountFormComponent = BaseFormComponent.extend
  subscription: Ember.inject.service()

  modelType: 'account'
  plans: null

  horizontal: false
  savedAction: null
  'show-delete': false

  'option-groups': Ember.computed ->
    plan: Registration.plans

  fields: [
    name: 'name'
    label: false
    required: true
  ]

`export default AccountFormComponent`
