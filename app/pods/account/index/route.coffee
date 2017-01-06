`import Ember from 'ember'`
`import EditRoute from 'gateway-ui/pods/edit/route'`

# Account index is actually an edit route.
AccountIndexRoute = EditRoute.extend
  actions:
    'new-key': ->
      @transitionTo 'keys.new'

`export default AccountIndexRoute`
