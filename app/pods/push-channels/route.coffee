`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushChannelsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'push-channel'
  setupController: (controller, model)->
    @_super arguments...
    @store.findAll('api').then (apis) ->
      controller.set 'apis', apis
    @store.findAll('remote-endpoint').then (remote_endpoints) ->
      controller.set 'remote_endpoints', remote_endpoints
  actions:
    refresh: -> @refresh()

`export default PushChannelsRoute`
