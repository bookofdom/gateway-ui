`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ApisRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'api'
  actions:
    refresh: -> @refresh()

`export default ApisRoute`
