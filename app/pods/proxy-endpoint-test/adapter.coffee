`import ProxyEndpointRelatedAdapter from 'gateway/pods/proxy-endpoint-related/adapter'`
`import config from  'gateway/config/environment'`

ProxyEndpointTestAdapter = ProxyEndpointRelatedAdapter.extend
  buildTestUrl: (model) ->
    snapshot = model._createSnapshot()
    "#{@buildURL 'proxy-endpoint-test', null, snapshot}/test"

  ###
  model:  environment instance
  ###
  executeTest: (model) ->
    url = @buildTestUrl model
    new Ember.RSVP.Promise (resolve, reject) =>
      @ajax(url, 'GET').then (response) ->
        result = response?.results?[0]
        if result
          result.method = model.get 'method' # for consistency
          result.route = model.get 'route' # for convenience
          result.error = +result.status > 300
          resolve result
        else
          reject response

`export default ProxyEndpointTestAdapter`
