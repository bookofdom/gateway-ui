`import Ember from 'ember'`
`import EditController from 'gateway/controllers/edit'`

# Account index is actually an edit controller.
AccountIndexController = EditController.extend
  breadCrumb: null
  account: Ember.inject.controller()
  subscription_plans: Ember.computed.alias 'account.subscription_plans'

`export default AccountIndexController`
