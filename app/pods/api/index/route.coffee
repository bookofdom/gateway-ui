`import Ember from 'ember'`


ApiIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'proxy-endpoints'

`export default ApiIndexRoute`
