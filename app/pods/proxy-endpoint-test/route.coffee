`import Ember from 'ember'`


ProxyEndpointTestRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('proxy-endpoint-tests').findBy 'id', params.proxy_endpoint_test_id
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoint-tests'

`export default ProxyEndpointTestRoute`
