`import Ember from 'ember'`

AccountKeysNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'account-keys': Ember.inject.controller()

  indexModel: Ember.computed.alias 'account-keys.model'

`export default AccountKeysNewController`
