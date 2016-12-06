`import Ember from 'ember'`

ProxyEndpointChannelRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('proxy-endpoint-channels').findBy 'id', params.proxy_endpoint_channel_id

`export default ProxyEndpointChannelRoute`
