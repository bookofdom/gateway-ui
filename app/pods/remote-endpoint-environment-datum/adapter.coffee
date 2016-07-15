`import ApplicationAdapter from 'gateway/adapters/application'`
`import config from  'gateway/config/environment'`

RemoteEndpointEnvironmentDatumAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'remote_endpoint', 'environment_data'

`export default RemoteEndpointEnvironmentDatumAdapter`
