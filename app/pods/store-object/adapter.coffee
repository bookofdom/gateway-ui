`import DS from 'ember-data'`
`import ApplicationAdapter from 'gateway/pods/application/adapter'`
`import t from 'gateway/helpers/i18n'`


getJsonValidationError = (snapshot) ->
  body = snapshot.attributes().body
  try
    JSON.parse body if body
    null
  catch e
    new DS.InvalidError [
      detail: t 'errors.invalid-json'
      source:
        pointer: '/data/attributes/body'
    ]

createOrUpdateRecord = (store, type, snapshot) ->
  err = getJsonValidationError snapshot
  if err
    Ember.RSVP.reject err
  else
    @_super arguments...


StoreObjectAdapter = ApplicationAdapter.extend
  errorMappings:
    data: 'body'

  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    host = @get 'host'
    url = url.replace host, ''
    collectionId = snapshot?.belongsTo?('store_collection').id
    if collectionId
      url = "#{@pathForType('store-collection')}/#{collectionId}/#{url}"
    url = "#{host}/#{url}"
    @cleanURL url

  createRecord: createOrUpdateRecord
  updateRecord: createOrUpdateRecord

`export default StoreObjectAdapter`
