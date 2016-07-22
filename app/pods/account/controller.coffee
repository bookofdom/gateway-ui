`import Ember from 'ember'`

AccountController = Ember.Controller.extend
  breadCrumb: Ember.computed 'model.displayName', -> @get 'model.displayName'

`export default AccountController`
