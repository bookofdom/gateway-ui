`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ApiRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) -> @modelFor('apis').findBy 'id', params.api_id

`export default ApiRoute`
