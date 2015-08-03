`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ProxyEndpointTestAdapter = ApplicationAdapter.extend
  buildURL: (type, id, record) ->
    if record
      # models
      proxyEndpoint = record.get 'proxy_endpoint'
      # adapters
      proxyEndpointAdapter = @container.lookup 'adapter:proxy-endpoint'
      # IDs
      testId = record.get 'id'
      proxyEndpointId = proxyEndpoint.get 'id'
      # URLs
      proxyEndpointTypeKey = proxyEndpoint.constructor.typeKey
      proxyEndpointUrl = proxyEndpointAdapter.buildURL proxyEndpointTypeKey, proxyEndpointId, proxyEndpoint
      "#{proxyEndpointUrl}/tests/#{testId}"

  buildTestUrl: (record) ->
    "#{@buildURL null, null, record}/test"

  ###
  record:  environment instance
  ###
  executeTest: (record) ->
    url = @buildTestUrl record
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        if response?[0]
          resolve response[0]
        else
          reject response

`export default ProxyEndpointTestAdapter`
