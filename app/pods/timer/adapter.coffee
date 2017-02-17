`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`


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


TimerAdapter = ApplicationAdapter.extend
  createRecord: createOrUpdateRecord
  updateRecord: createOrUpdateRecord

`export default TimerAdapter`
