`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway/pods/application/adapter'`
`import StripeCardAdapterMixin from 'gateway/mixins/stripe-card-adapter'`

AccountAdapter = ApplicationAdapter.extend StripeCardAdapterMixin,
  pathForType: (type) ->
    path = @_super type
    path = path.singularize()
    path
  buildURL: ->
    url = @_super arguments...
    # strip ID portion of URL:  account is always a singular resource
    url = url.replace /\/\d*$/, ''
    url

`export default AccountAdapter`
