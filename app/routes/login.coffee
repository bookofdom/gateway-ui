`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'simple-auth/mixins/unauthenticated-route-mixin'`
`import config from  '../config/environment'`

LoginRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  devMode: config.devMode?.toString() is 'true'
  beforeModel: ->
    # redirect to after auth route if in dev mode
    @transitionTo config['simple-auth'].routeAfterAuthentication if @get('devMode')

`export default LoginRoute`
