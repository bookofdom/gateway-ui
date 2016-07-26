`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`

AccountEditRoute = EditRoute.extend
  actions:
    saved: ->
      @transitionTo 'accounts'

`export default AccountEditRoute`
