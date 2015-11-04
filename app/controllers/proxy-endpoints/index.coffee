`import Ember from 'ember'`

ProxyEndpointsIndexController = Ember.Controller.extend
  'proxy-endpoints': Ember.inject.controller()

  filtered: Ember.computed 'model', 'proxy-endpoints.environment_id', ->
    environment_id = @get 'proxy-endpoints.environment_id'
    model = @get 'model'
    if environment_id
      model = model.filterBy 'environment.id', environment_id
    model

`export default ProxyEndpointsIndexController`
