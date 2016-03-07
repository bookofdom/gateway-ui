`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointEnvironmentDatumScratchPadSerializer = ApplicationSerializer.extend
  modelNameFromPayloadKey: (payloadKey) ->
    'remote-endpoint-environment-datum-scratch-pad'
  payloadKeyFromModelName: (modelName) ->
    'scratch_pad'

`export default RemoteEndpointEnvironmentDatumScratchPadSerializer`
