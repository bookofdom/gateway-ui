`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointTestsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('proxy-endpoint').get 'tests'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default ProxyEndpointTestsRoute`
