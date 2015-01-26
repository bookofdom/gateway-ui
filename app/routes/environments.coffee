`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EnvironmentsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    #@store.find 'environment'

`export default EnvironmentsRoute`
