`import Ember from 'ember'`


ProxyEndpointRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('proxy-endpoints').findBy 'id', params.proxy_endpoint_id
  afterModel: ->
    # routes and components embedded records appear only when
    # loading individual proxy endpoints
    proxyEndpoint = @modelFor 'proxy-endpoint'
    proxyEndpoint.cancel()
  renderTemplate: ->
    @_super arguments...
    @render 'proxy-endpoints/nav-items',
      outlet: 'nav-items'
      into: 'proxy-endpoint'
    @render 'proxy-endpoints/nav-items-secondary',
      outlet: 'nav-items-secondary'
      into: 'proxy-endpoint'
  actions:
    'proxy-endpoint-component-edit': (model) ->
      # no op
    deleted: ->
      @transitionTo 'proxy-endpoints'

`export default ProxyEndpointRoute`
