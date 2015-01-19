`import Ember from 'ember'`

ApisRoute = Ember.Route.extend
  model: -> @store.find 'api'

`export default ApisRoute`
