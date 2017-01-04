`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

# inserts the related API path in front of the resource path
# many resource URLs are nested under API

ApiRelatedAdapter = ApplicationAdapter.extend
  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    host = @get 'host'
    url = url.replace host, ''
    apiId = snapshot?.belongsTo?('api').id
    if apiId
      url = "#{@pathForType('api')}/#{apiId}/#{url}"
    url = "#{host}/#{url}"
    @cleanURL url

`export default ApiRelatedAdapter`
