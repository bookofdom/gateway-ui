`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ScratchPadAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    if snapshot
      # snapshots
      environmentDatumSnapshot = snapshot.belongsTo 'remote_endpoint_environment_data'
      remoteEndpointSnapshot = environmentDatumSnapshot.belongsTo 'remote_endpoint'
      # adapters
      remoteEndpointAdapter = @container.lookup 'adapter:remote-endpoint'
      # IDs
      snapshotId = snapshot.id
      environmentDatumId = environmentDatumSnapshot.id
      remoteEndpointId = remoteEndpointSnapshot.id
      # URLs
      remoteEndpointModelName = remoteEndpointSnapshot.modelName
      remoteEndpointUrl = remoteEndpointAdapter.buildURL remoteEndpointModelName, remoteEndpointId, remoteEndpointSnapshot
      if snapshotId
        url = "#{remoteEndpointUrl}/environment_data/#{environmentDatumId}/scratch_pads/#{snapshotId}"
      else
        url = "#{remoteEndpointUrl}/environment_data/#{environmentDatumId}/scratch_pads"
      @cleanURL url

  buildTestUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'scratch-pad', null, snapshot}/test"

  ###
  model:  environment instance
  ###
  executeTest: (model) ->
    url = @buildTestUrl model
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        if response
          resolve response
        else
          reject response

`export default ScratchPadAdapter`
