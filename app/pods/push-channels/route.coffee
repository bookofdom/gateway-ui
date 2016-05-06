`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushChannelsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'push-channel'
  actions:
    refresh: -> @refresh()

`export default PushChannelsRoute`
