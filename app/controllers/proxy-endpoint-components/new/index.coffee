`import Ember from 'ember'`

ProxyEndpointComponentsNewIndexController = Ember.Controller.extend
  'proxy-endpoint-components': Ember.inject.controller()
  components: Ember.computed 'proxy-endpoint-components.model.[]', ->
    @get 'proxy-endpoint-components.model'

`export default ProxyEndpointComponentsNewIndexController`
