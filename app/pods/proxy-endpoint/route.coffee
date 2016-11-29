`import Ember from 'ember'`


ProxyEndpointRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('proxy-endpoints').findBy 'id', params.proxy_endpoint_id
  afterModel: ->
    # routes and components embedded records appear only when
    # loading individual proxy endpoints
    proxyEndpoint = @modelFor 'proxy-endpoint'
    # Proxy endpoints as loaded in the index are incomplete.
    # Cancel (implicitly reload) the proxy endpoint to get all data associated
    # with the record.
    # Does not reload if the proxy endpoint is dirty, which could happen if
    # entering the new record flow and returning.
    if !proxyEndpoint.get 'hasDirtyAttributes'
      proxyEndpoint.cancel()
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoints'
    componentMoved: (id, position) ->
      @modelFor('proxy-endpoint').moveComponentByIdTo id, position

`export default ProxyEndpointRoute`
