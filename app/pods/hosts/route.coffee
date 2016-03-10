`import Ember from 'ember'`


HostsRoute = Ember.Route.extend 
  model: -> @modelFor('api').get 'hosts'

`export default HostsRoute`
