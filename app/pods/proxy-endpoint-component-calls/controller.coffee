`import Ember from 'ember'`

ProxyEndpointComponentCallsController = Ember.Controller.extend
  breadCrumb: 'resources.proxy-endpoint-component-call_plural'

  'api': Ember.inject.controller()
  'proxy-endpoint-component-calls': Ember.inject.controller()

  indexModel: Ember.computed.alias 'model'
  'option-groups': Ember.computed 'api.libraries', 'api.remote_endpoints.@each.isNew', ->
    conditional: @get 'api.libraries'
    remote_endpoint: @get('api.remote_endpoints').filterBy 'isNew', false

`export default ProxyEndpointComponentCallsController`
