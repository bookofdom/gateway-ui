`import Ember from 'ember'`

ApiRoute = Ember.Route.extend
  model: -> @store.find 'api'

`export default ApiRoute`
