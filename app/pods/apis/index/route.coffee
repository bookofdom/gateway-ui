`import Ember from 'ember'`

# Account index is actually an edit route.
ApisIndexRoute = Ember.Route.extend
  actions:
    saved: (model) ->
      @transitionTo 'api', model

`export default ApisIndexRoute`
