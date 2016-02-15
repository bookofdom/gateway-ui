`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

LibraryRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('libraries').findBy 'id', params.library_id
  actions:
    deleted: ->
      @transitionTo 'libraries'

`export default LibraryRoute`
