`import Ember from 'ember'`


HostRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('hosts').findBy 'id', params.host_id
  actions:
    deleted: ->
      @transitionTo 'hosts'

`export default HostRoute`
