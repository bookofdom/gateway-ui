`import Ember from 'ember'`


ApiDocumentationDetailRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('api-documentation').findBy 'id', params.host_id

`export default ApiDocumentationDetailRoute`
