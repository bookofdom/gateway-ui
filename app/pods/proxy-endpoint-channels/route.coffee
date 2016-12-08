`import Ember from 'ember'`

ProxyEndpointChannelsRoute = Ember.Route.extend
  model: -> @modelFor('proxy-endpoint').get 'channels'

`export default ProxyEndpointChannelsRoute`
