`import Ember from 'ember'`


LibraryIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'library.edit'

`export default LibraryIndexRoute`
