`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway/pods/application/adapter'`
`import t from 'gateway/helpers/i18n'`


getJsonValidationError = (snapshot) ->
  parameters = snapshot.attributes().parameters
  try
    JSON.parse parameters if parameters
    null
  catch e
    new DS.InvalidError [
      detail: t 'errors.invalid-json'
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
