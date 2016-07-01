`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushChannelsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'push-channel'
  renderTemplate: ->
    @_super arguments...
    @render 'push/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push-channels'
  actions:
    refresh: -> @refresh()

`export default PushChannelsRoute`
