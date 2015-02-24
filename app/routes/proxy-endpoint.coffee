`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoints').findBy 'id', params.proxy_endpoint_id
  afterModel: ->
    # routes and components embedded records appear only when
    # loading individual proxy endpoints
    proxyEndpoint = @modelFor 'proxy-endpoint'
    proxyEndpoint.rollback()
    proxyEndpoint.reload()
  actions:
    # TODO
    # Transitioning to the same route with a different model is not currently
    # supported in Ember.  To work-around this issue, we first transition away
    # from the component edit route and then back to it with the new model.
    'proxy-endpoint-component-edit': (model) ->
      @transitionTo('proxy-endpoint').then (=>), =>
        Ember.run.schedule 'afterRender', @, =>
          @transitionTo 'proxy-endpoint-component.edit', model

`export default ProxyEndpointRoute`
