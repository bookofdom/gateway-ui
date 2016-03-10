`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ApiDocumentationRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'hosts'

`export default ApiDocumentationRoute`
