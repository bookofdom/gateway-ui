`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ApiDocumentationIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  onActivate: Ember.on 'activate', ->
    firstHost = @modelFor('api-documentation')?.get 'firstObject'
    if firstHost
      Ember.run.later (=>
        @transitionTo 'api-documentation-detail.index', firstHost
      ), 500

`export default ApiDocumentationIndexRoute`
