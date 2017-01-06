`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

RemoteEndpointEnvironmentDatumAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'remote_endpoint', 'environment_data'

`export default RemoteEndpointEnvironmentDatumAdapter`
