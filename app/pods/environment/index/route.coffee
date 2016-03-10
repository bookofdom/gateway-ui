`import Ember from 'ember'`


EnvironmentIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'environment.edit'

`export default EnvironmentIndexRoute`
