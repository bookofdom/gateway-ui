`import JobRelatedAdapter from 'gateway-ui/pods/job-related/adapter'`
`import config from  'gateway-ui/config/environment'`
`import DS from 'ember-data'`

getJsonValidationError = (snapshot) ->
  parameters = snapshot.attributes().parameters
  try
    JSON.parse parameters if parameters
    null
  catch e
    new DS.InvalidError [
      detail: 'errors.invalid-json'
      source:
        pointer: '/data/attributes/parameters'
    ]

createOrUpdateRecord = (store, type, snapshot) ->
  err = getJsonValidationError snapshot
  if err
    Ember.RSVP.reject err
  else
    @_super arguments...

JobTestAdapter = JobRelatedAdapter.extend
  createRecord: createOrUpdateRecord
  updateRecord: createOrUpdateRecord

  buildTestUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'job-test', null, snapshot}/test"

  ###
  model:  environment instance
  ###
  executeTest: (model) ->
    url = @buildTestUrl model
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        result = response?.result
        if result
          resolve result
        else
          reject response

`export default JobTestAdapter`
