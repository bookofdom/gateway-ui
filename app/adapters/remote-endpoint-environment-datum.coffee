`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

RemoteEndpointEnvironmentDatumAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'remote_endpoint', 'environment_data'

`export default RemoteEndpointEnvironmentDatumAdapter`
