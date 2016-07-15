`import ApplicationAdapter from 'gateway/adapters/application'`
`import config from  'gateway/config/environment'`

RemoteEndpointEnvironmentDatumScratchPadAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'environment_datum', 'scratch_pads'

  buildExecuteUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'scratch-pad', null, snapshot}/execute"

  ###
  model:  environment instance
  ###
  execute: (model) ->
    url = @buildExecuteUrl model
    new Ember.RSVP.Promise (resolve, reject) =>
      Ember.$.ajax
        url: url
        type: 'GET'
        dataType: 'json'
      .then (response) ->
        resolve response
      , (xhr, status, error) ->
        reject xhr.responseJSON


`export default RemoteEndpointEnvironmentDatumScratchPadAdapter`
