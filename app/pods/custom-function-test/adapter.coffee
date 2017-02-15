`import CustomFunctionRelatedAdapter from 'gateway-ui/pods/custom-function-related/adapter'`
`import config from  'gateway-ui/config/environment'`
`import DS from 'ember-data'`

getJsonValidationError = (snapshot) ->
  input = snapshot.attributes().input
  try
    JSON.parse input if input
    null
  catch e
    new DS.InvalidError [
      detail: 'errors.invalid-json'
      source:
        pointer: '/data/attributes/input'
    ]

createOrUpdateRecord = (store, type, snapshot) ->
  err = getJsonValidationError snapshot
  if err
    Ember.RSVP.reject err
  else
    @_super arguments...

CustomFunctionTestAdapter = CustomFunctionRelatedAdapter.extend
  createRecord: createOrUpdateRecord
  updateRecord: createOrUpdateRecord

  buildTestUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'custom-function-test', null, snapshot}/test"

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

`export default CustomFunctionTestAdapter`
