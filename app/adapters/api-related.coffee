`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

# inserts the related API path in front of the resource path
# many resource URLs are nested under API

ApiRelatedAdapter = ApplicationAdapter.extend
  buildURL: (type, id, record) ->
    url = @_super.apply @, arguments
    basePath = config.api.basePath
    url = url.split "/#{basePath}/"
    apiId = record?.get 'api.id'
    if apiId and basePath
      url.insertAt 1, apiId
      url.insertAt 1, @pathForType('api')
      url.insertAt 1, basePath if basePath
    url = url.filter((value) -> !!value).join '/'
    # if this is a relative path (because no API host was specified),
    # then add an initial slash to make the path absolute
    url = "/#{url}" if !config.api.host
    url

`export default ApiRelatedAdapter`
