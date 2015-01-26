`import Ember from 'ember'`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`
`import { slugify } from 'gateway/helpers/slugify'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  actions:
    sessionAuthenticationFailed: (error) ->
      message = slugify error
      loginController = @controllerFor('login')
      loginController.set 'authenticationError', message

`export default ApplicationRoute`
