`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ApiDocumentationDetailRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('api-documentation').findBy 'id', params.host_id

`export default ApiDocumentationDetailRoute`
