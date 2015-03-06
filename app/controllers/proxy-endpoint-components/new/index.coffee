`import Ember from 'ember'`

ProxyEndpointComponentsNewIndexController = Ember.Controller.extend
  needs: ['proxy-endpoint-components']
  components: Ember.computed 'controllers.proxy-endpoint-components.model.@each', ->
    @get 'controllers.proxy-endpoint-components.model'

`export default ProxyEndpointComponentsNewIndexController`
