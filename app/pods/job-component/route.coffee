`import Ember from 'ember'`

JobComponentRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('proxy-endpoint-components').findBy 'id', params.proxy_endpoint_component_id
  actions:
    deleted: ->
      @transitionTo 'job'

`export default JobComponentRoute`
