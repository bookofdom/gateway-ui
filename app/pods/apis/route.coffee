`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ApisRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'api'
  actions:
    refresh: -> @refresh()
    saved: ->
      # no op

`export default ApisRoute`
