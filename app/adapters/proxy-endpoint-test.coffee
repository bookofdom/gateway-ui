`import ProxyEndpointRelatedAdapter from './proxy-endpoint-related'`
`import config from  '../config/environment'`

ProxyEndpointTestAdapter = ProxyEndpointRelatedAdapter.extend
  buildTestUrl: (record) ->
    snapshot = record._createSnapshot()
    "#{@buildURL 'proxy-endpoint-test', null, snapshot}/test"

  ###
  record:  environment instance
  ###
  executeTest: (record) ->
    url = @buildTestUrl record
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        result = response?.results?[0]
        if result
          result.method = record.get 'method' # for consistency
          result.route = record.get 'route' # for convenience
          result.error = +result.status > 300
          resolve result
        else
          reject response

`export default ProxyEndpointTestAdapter`
