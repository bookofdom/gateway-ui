`import Ember from 'ember'`

ProxyEndpointsIndexController = Ember.Controller.extend
  'proxy-endpoints': Ember.inject.controller()

  filtered: Ember.computed 'model', 'proxy-endpoints.environment_id', 'proxy-endpoints.endpoint_group_id', ->
    environment_id = @get 'proxy-endpoints.environment_id'
    endpoint_group_id = @get 'proxy-endpoints.endpoint_group_id'
    model = @get 'model'
    if environment_id
      model = model.filterBy 'environment.id', environment_id
    if endpoint_group_id
      model = model.filterBy 'endpoint_group.id', endpoint_group_id
    model

`export default ProxyEndpointsIndexController`
