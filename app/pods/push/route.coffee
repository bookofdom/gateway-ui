`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    Ember.RSVP.hash
      apis: @store.findAll('api')
      remote_endpoints: @store.findAll('remote-endpoint')

`export default PushRoute`
