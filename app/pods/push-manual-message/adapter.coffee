`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`


getJsonValidationError = (snapshot) ->
  body = snapshot.attributes().body
  try
    JSON.parse body if body
    null
  catch e
    new DS.InvalidError [
      detail: 'errors.invalid-json'
      source:
        pointer: '/data/attributes/body'
    ]

createOrUpdateRecord = (store, type, snapshot) ->
  err = getJsonValidationError snapshot
  if err
    Ember.RSVP.reject err
  else
    @_super arguments...


PushManualMessageAdapter = ApplicationAdapter.extend
  errorMappings:
    payload: 'body'

  buildURL: (type, id, snapshot) ->
    @generateURL snapshot, 'push_channel', 'push_manual_messages'

  createRecord: createOrUpdateRecord
  updateRecord: createOrUpdateRecord

`export default PushManualMessageAdapter`
