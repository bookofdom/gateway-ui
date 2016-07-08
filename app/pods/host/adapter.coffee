`import ApiRelatedAdapter from 'gateway/adapters/api-related'`
`import config from  'gateway/config/environment'`

HostAdapter = ApiRelatedAdapter.extend
  buildSwaggerViewerUrl: (model) ->
    jsonUrl = @buildSwaggerJsonUrl model
    jsonUrl = encodeURIComponent jsonUrl
    url = config.api.swaggerViewerPath
    url = @buildURL('swagger') if !url
    url = url.replace /^\/\//g, '/' # replace double leading slashes
    "#{url}.html?url=#{jsonUrl}"

  buildSwaggerJsonUrl: (model) ->
    snapshot = model._createSnapshot()
    protocol = location.protocol
    hostname = snapshot.attributes().hostname
    port = location.port
    host = if port then "#{hostname}:#{port}" else hostname
    path = '/swagger'
    url = config.api.swaggerJsonPath
    url = "#{protocol}//#{host}#{path}" if !url
    "#{url}.json"

`export default HostAdapter`
