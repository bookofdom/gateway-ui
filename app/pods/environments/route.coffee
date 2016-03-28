`import Ember from 'ember'`


EnvironmentsRoute = Ember.Route.extend 
  model: -> @modelFor('api').get 'environments'

`export default EnvironmentsRoute`
