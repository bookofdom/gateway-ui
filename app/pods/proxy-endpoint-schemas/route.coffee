`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointSchemasRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('proxy-endpoint').get 'schemas'
  actions:
    saved: ->
      # no op (this event is for use by the new type schema route)

`export default ProxyEndpointSchemasRoute`
