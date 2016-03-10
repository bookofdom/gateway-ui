`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`
`import config from  'gateway/config/environment'`

LoginRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  devMode: config.devMode?.toString() is 'true'
  beforeModel: ->
    # redirect to after auth route if in dev mode
    @transitionTo config['simple-auth'].routeAfterAuthentication if @get('devMode')
    @_super arguments...

`export default LoginRoute`
