`import Ember from 'ember'`

ApiRoute = Ember.Route.extend
  model: (params) -> @modelFor('apis').findBy 'id', params.api_id
  setupController: (controller, model) ->
    @_super controller, model
    controller.set 'breadCrumb', model.get('name')

`export default ApiRoute`
