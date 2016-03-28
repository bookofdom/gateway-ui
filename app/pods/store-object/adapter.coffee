`import ApplicationAdapter from 'gateway/adapters/application'`
`import t from 'gateway/helpers/i18n'`

StoreObjectAdapter = ApplicationAdapter.extend
  errorMappings:
    data: 'body'

  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    host = @get 'host'
    url = url.replace host, ''
    collectionId = snapshot?.belongsTo('store_collection').id
    if collectionId
      url = "#{@pathForType('store-collection')}/#{collectionId}/#{url}"
    url = "#{host}/#{url}"
    @cleanURL url

  # Raises a JSON serialization error if the serializer
  # reports that one occured.
  ajax: (url, type, options) ->
    hasError = options?.data?.store_object?.dataError
    if hasError
      Ember.RSVP.reject new DS.InvalidError [
        detail: t 'errors.invalid-json'
        source:
          pointer: '/data/attributes/body'
      ]
    else
      @_super arguments...

`export default StoreObjectAdapter`
