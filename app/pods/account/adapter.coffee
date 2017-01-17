`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`

AccountAdapter = ApplicationAdapter.extend
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
