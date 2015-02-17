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
      url.insertAt 1, basePath
      url.insertAt 2, @pathForType('api')
      url.insertAt 3, apiId
    url = url.filter((value) -> !!value).join '/'
    url

`export default ApiRelatedAdapter`
