`import ApiRelatedAdapter from './api-related'`
`import config from  '../config/environment'`

HostAdapter = ApiRelatedAdapter.extend
  buildSwaggerViewerUrl: (record) ->
    jsonUrl = @buildSwaggerJsonUrl record
    jsonUrl = encodeURIComponent jsonUrl
    url = config.api.swaggerViewerPath
    url = @buildURL('swagger') if !url
    "#{url}.html?url=#{jsonUrl}"

  buildSwaggerJsonUrl: (record) ->
    snapshot = record._createSnapshot()
    protocol = location.protocol
    hostname = snapshot.get 'hostname'
    port = location.port
    host = if port then "#{hostname}:#{port}" else hostname
    path = '/swagger'
    url = "#{config.api.swaggerJsonPath}"
    url = "#{protocol}//#{host}#{path}" if !url
    "#{url}.json"

`export default HostAdapter`
