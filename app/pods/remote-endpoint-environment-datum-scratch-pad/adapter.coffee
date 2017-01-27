`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

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
        crossDomain: true
        xhrFields:
          withCredentials: true
      .then (response) ->
        resolve response
      , (xhr, status, error) ->
        reject xhr.responseJSON


`export default RemoteEndpointEnvironmentDatumScratchPadAdapter`
