`import ProxyEndpointRelatedAdapter from './proxy-endpoint-related'`
`import config from  '../config/environment'`

ProxyEndpointTestAdapter = ProxyEndpointRelatedAdapter.extend
  recordPath: 'tests'

  buildTestUrl: (record) ->
    snapshot = record._createSnapshot()
    "#{@buildURL null, null, snapshot}/test"

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
