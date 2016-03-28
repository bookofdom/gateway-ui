`import Ember from 'ember'`


LibraryRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('libraries').findBy 'id', params.library_id
  actions:
    deleted: ->
      @transitionTo 'libraries'

`export default LibraryRoute`
