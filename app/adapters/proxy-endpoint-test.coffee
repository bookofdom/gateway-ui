`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ProxyEndpointTestAdapter = ApplicationAdapter.extend
  testUrl: Ember.computed ->
    url = []
    url.push config.api.url
    url.push 'apis'
    url.push @get('proxy_endpoint.api.id')
    url.push 'proxy_endpoints'
    url.push @get('proxy_endpoint.id')
    url.push 'tests'
    url.push @get('id')
    url.push 'test'
    url = url.join '/'
    host = "#{window.location.protocol}//#{window.location.host}"
    url = "#{host}#{url}" if !config.api.host
    url

`export default ProxyEndpointTestAdapter`
