`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointComponentsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('proxy-endpoint').get 'components'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default ProxyEndpointComponentsRoute`
