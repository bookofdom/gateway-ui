`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ProxyEndpointTestAdapter = ApplicationAdapter.extend
  buildTestUrl: (record) ->
    store = @store
    testId = record.get 'id'
    new Ember.RSVP.Promise (resolve, reject) =>
      proxyEndpoint = record.get 'proxy_endpoint'
      id = proxyEndpoint.get 'id'
      typeKey = proxyEndpoint.constructor.typeKey
      adapter = @container.lookup 'adapter:proxy-endpoint'
      url = adapter.buildURL typeKey, id, @
      url = "#{url}/tests/#{testId}/test"
      resolve url

  ###
  record:  environment instance
  ###
  executeTest: (record) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @buildTestUrl(record).then (url) =>
        console.log url
        #data =
        #  environment_id: record.get 'environment.id'
        #  deployment_id: record.get 'id'
        #@ajax(url, 'POST', data: data).then resolve, reject

`export default ProxyEndpointTestAdapter`
