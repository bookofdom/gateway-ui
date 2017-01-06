`import Ember from 'ember'`

NewRoute = Ember.Route.extend
  queryParams:
    next:
      refreshModel: false

`export default NewRoute`
