`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushChannelsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'push-channel'
  setupController: (controller, model)->
    @_super arguments...
    @store.findAll('api').then (api) ->
      controller.set 'api', api
  actions:
    refresh: -> @refresh()

`export default PushChannelsRoute`
