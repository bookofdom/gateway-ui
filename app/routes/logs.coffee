`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

LogsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    query:
      refreshModel: true
    start:
      refreshModel: true
    end:
      refreshModel: true
    limit:
      refreshModel: true

  model: (params) -> @store.findQuery 'log', params

`export default LogsRoute`
