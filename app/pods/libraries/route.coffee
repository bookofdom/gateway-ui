`import Ember from 'ember'`


LibrariesRoute = Ember.Route.extend 
  model: -> @modelFor('api').get 'libraries'

`export default LibrariesRoute`
