`import Ember from 'ember'`


HostIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'host.edit'

`export default HostIndexRoute`
