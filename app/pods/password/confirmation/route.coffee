`import Ember from 'ember'`

PasswordResetConfirmationRoute = Ember.Route.extend
  queryParams:
    token: true

`export default PasswordResetConfirmationRoute`
