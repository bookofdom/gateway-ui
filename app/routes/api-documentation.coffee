`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ApiDocumentationRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'hosts'
  afterModel: ->
    firstHost = @modelFor('api-documentation')?.get 'firstObject'
    if firstHost
      @transitionTo 'api-documentation-detail', firstHost

`export default ApiDocumentationRoute`
