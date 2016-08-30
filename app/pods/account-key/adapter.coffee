`import ApplicationAdapter from 'gateway/adapters/application'`
`import config from  'gateway/config/environment'`

AccountKeyAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = @super arguments...
    path = path.replace 'account_key', 'key'
    path
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'account', 'keys'

`export default AccountKeyAdapter`
