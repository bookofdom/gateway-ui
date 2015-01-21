`import Ember from 'ember'`

ApiRoute = Ember.Route.extend
  model: (params) -> @modelFor('apis').findBy 'id', params.api_id

`export default ApiRoute`
